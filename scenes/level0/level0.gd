extends Node2D
class_name Level0

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene
export (NodePath) var player_path

var start_dialogue = false
var current_dialogue_name = ""
var current_dialogue_index = 0

var dialogues_level0B = [
	"[Raka?]\nOh no, you are NOT gonna catch me!",
]

var dialogues_level0C = [
	"[Strong Voice]\nThat monster ain't got game on me. What's next?",
	"[Smart Voice]\nLook at that safe! It's got to be the least secure safe ever made. Doesn't take that long to figure out the password.",
	"[Strong Voice]\nSo I'll rip the door open and...",
	"[Smart Voice]\nNo no no... Let Raka figure it out. I've hidden the passcode in a note around the room. It shouldn't be that hard for a small brain like him.",
]

var dialogues_level0D = [
	"[Raka?]\nYou want another round, huh? Come and get me!",
]

var player: Player

signal dialogue_finish(dialogue_name)

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	PLAYER_STATES.restart_path = get_tree().current_scene.get_filename()
	player = get_node_or_null(player_path) # We use _or_null variant since not all level0 needs player for its interaction.
	$CanvasModulate.visible = true

	if self.name == "Level0C":
		player.inactive()
		$Timer0C.start()
	elif self.name == "Level0D":
		PLAYER_STATES.reset_inventory()

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and start_dialogue:
		if current_dialogue_name == "Level0C":
			_advance_dialogue(dialogues_level0C)

func _start_dialogue(dialogue_name, current_dialogues, current_expressions = null):
	current_dialogue_index = 0
	if current_expressions != null:
		ExpressionManager.emit_signal("show", current_expressions[current_dialogue_index])
	DialogueBoxManager.emit_signal("type", current_dialogues[current_dialogue_index])
	start_dialogue = true
	current_dialogue_name = dialogue_name

func _advance_dialogue(current_dialogues, current_expressions = null):
	if current_dialogue_index < current_dialogues.size() - 1:
		current_dialogue_index += 1
		if current_expressions != null:
			ExpressionManager.emit_signal("show", current_expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", current_dialogues[current_dialogue_index])
	else:
		ExpressionManager.emit_signal("hide")
		emit_signal("dialogue_finish", current_dialogue_name)
		start_dialogue = false
		current_dialogue_name = ""

func _on_NextLevel_body_entered(body:Node):
	if "player" in body.name.to_lower():
		body.inactive()
		if self.name == "Level0A":
			Level4SFX.stop_bgm(Level4SFX.bgm_player)
		if self.name == "Level0B":
			$Wall/EnemyPrologue.inactive()
		$TransitionScreen.change_scene(next_scene)

func _on_LocksafeUI_success():
	$Wall/Locksafe.unlock()
	$Wall/Locksafe.interact()
	DialogueBoxManager.emit_signal("type", "You open the safe.")

func _on_MonsterTrigger_body_entered(body:Node):
	if "player" in body.name.to_lower():
		player.inactive()
		$Wall/EnemyPrologue.play_noise()

		if self.name == "Level0B":
			DialogueBoxManager.emit_signal("type", "[Raka]\nWhat's that sound?")
			$AnimationPlayer.play("cutscene_0b_1")
			print($Wall/EnemyPrologue.speed)
		elif self.name == "Level0D":
			DialogueBoxManager.emit_signal("type", "[Raka]\nIt's that sound again!")
			$AnimationPlayer.play("cutscene_0d_1")

func _on_MonsterTrigger_body_exited(body:Node):
	if "player" in body.name.to_lower() and self.name in ["Level0B", "Level0D"]:
		$Wall/EnemyPrologue.active()
		$MonsterTrigger.queue_free()

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name in ["cutscene_0b_1", "cutscene_0d_1"]:
		player.active()
		player.switch_immediately(3)

		if self.name == "Level0B":
			_start_dialogue("Level0B", dialogues_level0B)
			yield(get_tree().create_timer(0.1), "timeout")
			player.inactive()
			$AnimationPlayer.play("cutscene_0b_2")
		elif self.name == "Level0D":
			_start_dialogue("Level0D", dialogues_level0D)
			yield(get_tree().create_timer(0.1), "timeout")
			player.inactive()
			$AnimationPlayer.play("cutscene_0d_2")

	if anim_name in ["cutscene_0b_2", "cutscene_0d_2"]:
		player.refocus_camera()
		player.active()

func _on_EndPrologue_body_entered(body:Node):
	if "player" in body.name.to_lower() and self.name in ["Level0D"]:
		DialogueBoxManager.emit_signal("type", "[Raka?]\nUh oh. That's not good...")
		player.play_idle("side-flip")
		player.inactive()
		$Wall/EnemyPrologue.inactive()
		
		# End camera functions
		$Camera2D.global_position = player.get_camera_position()
		$Camera2D.current = true
		$Tween.interpolate_property($Camera2D, "global_position", player.get_camera_position(), $Wall/EnemyPrologue.global_position, 1)
		$Tween.start()

		yield(get_tree().create_timer(3.0), "timeout")
		DialogueBoxManager.emit_signal("type", "[Raka?]\nYou are on your own, Raka!")
		$TransitionScreen.change_scene(next_scene)

func _on_Timer0C_timeout():
	player.active()
	_start_dialogue("Level0C", dialogues_level0C)

