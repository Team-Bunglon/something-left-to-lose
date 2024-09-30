extends Node2D

onready var animator = $AnimatedSprite

export (String) var next_scene

var dialogues = [	
	"[Raka]\nWhat a horrible week..\nI guess someone like me is really hopeless..",
	"[???]\nWell, you were exceptional at today’s physical exam.",
	"[???]\n...Exceptionally terrible.",
	"[Raka]\nUgh… terrible..",
	"[???]\nDid you remember yesterday?\nHow can someone fail an exam as easy as that?",
	"[???]\nHow unfathomable..",
	"[Raka]\nRight.. I am a failure..",
	"[Raka]\nHuh?! I think forgot my laptop..",
	"[???]\nOh.. We should help him.",
	"[???]\n...Right.\nGo back, Raka.",
	"[Raka]\nWhat?!\n...There's.. no one here..?",
	"[Raka]\n....Must be my imagination.",
	"[Raka]\nA-anyway, I have to go back!!"
]

var expressions = [
	"thinking",
	"ath-talk1",
	"ath-talk2",
	"embarassed1",
	"int-talk1",
	"int-talk2",
	"embarassed2",
	"surprised",
	"ath-reveal",
	"int-reveal",
	"noticed",
	"noticed2",
	"back"
]

var current_dialogue_index = 0

func _process(_delta):
	print(current_dialogue_index)
	if current_dialogue_index < dialogues.size():
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		animator.play(expressions[current_dialogue_index])
		current_dialogue_index += 1
	else:
		get_tree().change_scene(next_scene)
