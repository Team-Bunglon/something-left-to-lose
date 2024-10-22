extends Node2D
class_name Pre0

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene

onready var player: Player = $Wall/Player

var dialogues_first = [
	"[Unknown Voice 1]\nLook at him sitting there, he looks sad over those words on the email.",
	"[Unknown Voice 2]\nHe needs to smile a little. At least he still has other place to go. What should we do?",
	"[Unknown Voice 1]\nHow about we make him do some mental exercise? I'm sure he'll love it.",
	"[Unknown Voice 2]\nI was thinking of making him running around the house a little but that works too. I'm in.",
	"[Unknown Voice 1]\nExcellent! We'll wait until the time is juuuust right...",
]

var dialogues_second = [
	"[???]\nRaka, are you home? Your dad is home.",
	"[Raka's Father]\nI need to talk to you. Please come see me downstair!",
]

var start_dialogue := false
var current_dialogue_name = ""
var current_dialogue_index = 0

func _ready():
	player.inactive()
	pass

func _process(_delta):
	if not start_dialogue:
		return
	if Input.is_action_pressed("ui_accept") and current_dialogue_name == "first":
		if current_dialogue_index < dialogues_first.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_first[current_dialogue_index])
		else:
			start_dialogue = false
			$TransitionScreen.end_scene()
	if Input.is_action_pressed("ui_accept") and current_dialogue_name == "second":
		if current_dialogue_index < dialogues_second.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues_second[current_dialogue_index])
		else:
			start_dialogue = false
			get_tree().change_scene(next_scene)

func _on_TransitionScreen_finish_fade(anim_name):
	if anim_name == "start":
		current_dialogue_name = "first"
		current_dialogue_index = 0
		start_dialogue = true
		DialogueBoxManager.emit_signal("type", dialogues_first[current_dialogue_index])
	elif anim_name == "end":
		current_dialogue_name = "second"
		current_dialogue_index = 0
		start_dialogue = true
		DialogueBoxManager.emit_signal("type", dialogues_second[current_dialogue_index])

