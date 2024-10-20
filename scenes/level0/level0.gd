extends Node2D
class_name Level0

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene
export (NodePath) var player_path

var start_dialogue = false
var current_dialogue_name = ""
var current_dialogue_index = 0

var dialogues_level0A = [
	"[Raka]\nWait, why did I locked the door? Damn, I don't remember.",
	"[Raka]\nI guess I should find the key. Maybe I dropped it in a pile somewhere...",
]

var expressions_level0A = [
	"def-shocked",
	"def-neutral",
]

var dialogues_level0A_key = [
	"[Raka?]\nIf this room were mine, I would organize it better.",
	"[Raka?]\nOh well, time to move on.",
]

var dialogues_level0C = [
	"[Second Voice]\nThat monster ain't got game on me. What's next?",
	"[First Voice]\nLook at that safe! It's got to be the least secure safe ever made. Doesn't take that long to figure out the password.",
	"[Second Voice]\nSo I'll rip the door open and...",
	"[First Voice]\nNo no no... Let Raka figure it out. I've hidden the passcode around the room. It shouldn't be that hard for a small brain like him.",
]

var player: Player

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	player = get_node_or_null(player_path) # We use _or_null variant since not all level0 needs player for its interaction.
	$CanvasModulate.visible = true
	if self.name == "Level0C":
		_start_dialogue("Level0C", dialogues_level0C)

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and start_dialogue:
		if current_dialogue_name == "Level0A":
			_advance_dialogue(dialogues_level0A, expressions_level0A)
		elif current_dialogue_name == "Level0A_Key":
			_advance_dialogue(dialogues_level0A_key)
		elif current_dialogue_name == "Level0C":
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
		$Wall/Player.active()
		start_dialogue = false
		current_dialogue_name = ""

func _on_NextLevel_body_entered(body:Node):
	if "player" in body.name.to_lower():
		body.inactive()
		$TransitionScreen.change_scene(next_scene)

func _on_LocksafeUI_success():
	$WallFG/Locksafe.unlock()
	$WallFG/Locksafe.interact()
	DialogueBoxManager.emit_signal("type", "You open the safe.")

func _on_InteractDoor_open():
	if self.name == "Level0A":
		player.inactive()
		$Wall/InteractDoor.disable()
		$Wall/InteractClothes.disable()
		$Wall/InteractClothes2.enable()
		$LockedSFX.play()
		yield(get_tree().create_timer(1.0), "timeout")
		_start_dialogue("Level0A", dialogues_level0A, expressions_level0A)
		$Wall/SingleDoorBottom.enable()

func _on_Key_pick_up():
	if self.name == "Level0A":
		player.switch_immediately(2)
		$Wall/InteractSink.disable()
		$Wall/InteractSink2.enable()
		$Wall/InteractTable.disable()
		$Wall/InteractTable2.enable()
		yield(get_tree().create_timer(0.1), "timeout")
		_start_dialogue("Level0A_Key", dialogues_level0A_key)


