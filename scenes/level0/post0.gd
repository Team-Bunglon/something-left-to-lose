extends Node2D
class_name Post0

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene

var dialogues_1 = [
	"[???]\nRaka?",
	"[???]\nRaka!",
]

var dialogues_2 = [
	"RAKA!",
	"[Raka's Father]\nAre you hallucinating again?",
]

var dialogues_2_exp = [
	"dad-angry",
	"dad-neutral",
]

var dialogues_3_up = [
	"[Raka's Father]\nPlease don't lie to your father.",
	"[Raka's Father]\nI heard you running around at the stair and opening my safe... again!",
]

var dialogues_3_down = [
	"[Raka's Father]\n*Sigh* How long will you keep doing it?",
	"[Raka's Father]\nYou are a man, you should be better than this!",
]

var dialogues_4 = [
	"[Raka's Father]\nListen, tomorrow is your first day at university. Make sure you prepare everything you need.",
	"[Raka's Father]\nI'll lend you my paycard so you can ride the train tomorrow.",
	"[Raka's Father]\nGo to bed. And please don't make anymore noises!",
]

var start_dialogue := false
var current_dialogue_name = ""
var current_dialogue_index = 0

func _ready():
	$Wall/Player.inactive()
	$AnimationPlayer.play("cutscene")
	pass

func _process(_delta):
	if not start_dialogue:
		return

	if Input.is_action_pressed("ui_accept") and current_dialogue_name == "1":
		if current_dialogue_index < dialogues_1.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_1[current_dialogue_index])
		else:
			start_dialogue = false
			$AnimationPlayer.play("silence")

	elif Input.is_action_pressed("ui_accept") and current_dialogue_name == "2":
		if current_dialogue_index < dialogues_2.size() - 1:
			current_dialogue_index += 1
			ExpressionManager.emit_signall("show", dialogues_2_exp[current_dialogue_index])
			DialogueBoxManager.emit_signal("type", dialogues_2[current_dialogue_index])
		else:
			start_dialogue = false
			$up.visible = true
			$down.visible = true

	elif Input.is_action_pressed("ui_accept") and current_dialogue_name == "3up":
		if current_dialogue_index < dialogues_3_up.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_3_up[current_dialogue_index])
		else:
			start_dialogue = false
			$Timer4.start()
		current_dialogue_name = "2"
		current_dialogue_index = 0
		start_dialogue = true
		DialogueBoxManager.emit_signal("type", dialogues_2[current_dialogue_index])

	elif Input.is_action_pressed("ui_accept") and current_dialogue_name == "3down":
		if current_dialogue_index < dialogues_3_down.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_3_down[current_dialogue_index])
		else:
			start_dialogue = false
			$Timer4.start()

	elif Input.is_action_pressed("ui_accept") and current_dialogue_name == "4":
		if current_dialogue_index < dialogues_4.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_4[current_dialogue_index])
		else:
			start_dialogue = false
			$TransitionScreen.visible = true
			$CanvasLayer/Label.visible = true
			$TransitionScreen.change_scene(next_scene)

			#$TransitionScreen.end_scene()

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "cutscene":	
		current_dialogue_name = "1"
		current_dialogue_index = 0
		start_dialogue = true
		DialogueBoxManager.emit_signal("type", dialogues_1[current_dialogue_index])
	elif anim_name == "silence":	
		current_dialogue_name = "2"
		current_dialogue_index = 0
		start_dialogue = true
		ExpressionManager.emit_signal("show", dialogues_2_exp[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues_2[current_dialogue_index])
	elif anim_name == "temp_end":	
		get_tree().change_scene(next_scene)

func _on_up_pressed():
	$up.visible = false
	$down.visible = false
	current_dialogue_name = "3up"
	current_dialogue_index = 0
	start_dialogue = true
	DialogueBoxManager.emit_signal("type", dialogues_3_up[current_dialogue_index])

func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	current_dialogue_name = "3down"
	current_dialogue_index = 0
	start_dialogue = true
	DialogueBoxManager.emit_signal("type", dialogues_3_down[current_dialogue_index])

func _on_Timer4_timeout():
	current_dialogue_name = "4"
	current_dialogue_index = 0
	start_dialogue = true
	DialogueBoxManager.emit_signal("type", dialogues_4[current_dialogue_index])

func _on_TransitionScreen_finish_fade(anim_name:String):
	if anim_name == "end":
		$AnimationPlayer.play("temp_end")
