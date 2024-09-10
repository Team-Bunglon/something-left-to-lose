extends Node2D

export (String) var next_scene

var dialogues = [	
	"...",
	"......",
	"Tomorrow is the day I have to leave my home,\naway from my parents.",
	"I'm nervous about the physical exam tomorrow.\nI'm afraid of failing it.",
	"Those voices I heard. Those mocking voices about me. \nTelling me all sorts of names. How I'm so meek that I will certainly not pass the exam.",
	"What if they are right? What if I'm truly incapable of doing anything good for myself.",
	"If I truly fail tomorrow, My future is...",
]

var current_dialogue_index = 0

func _process(_delta):
	if current_dialogue_index < dialogues.size():
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		current_dialogue_index += 1
	else:
		return get_tree().change_scene(next_scene)
