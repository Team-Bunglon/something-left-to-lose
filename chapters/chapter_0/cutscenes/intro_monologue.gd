extends Node2D

export (String) var next_scene

var dialogues = [	
	"...",
	"......",
	"I still can't believe I've failed the exam.",
	"Those rejection letters... those words... It hurts to read through...",
	"And those voices I heard. Those mocking voices about me. \nTelling me all sorts of names. How I'm so meek that nobody will accept me.",
	"What if they are right? What if I'm truly incapable of doing anything good for myself.",
	"If I have nowhere to go, My future is...",
]

var current_dialogue_index = 0

func _process(_delta):
	if current_dialogue_index < dialogues.size():
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		current_dialogue_index += 1
	else:
		return get_tree().change_scene(next_scene)
