extends Node2D


onready var animator = $AnimatedSprite

var dialogues = [	
	"[Raka]\nWhat a horrible week..\nI guess Someone like me is really hopeless..",
	"[???]\nWell, you were exceptional at failing today’s physical exam",
	"[???]\nExceptionally terrible",
	"[Raka]\nUgh… terrible..",
	"[???]\nDid you remember yesterday?\nHow can someone fail an exam as easy as that?",
	"[???]\nHow unfathomable..",
	"[Raka]\nRight.. i am a failure..",
	"[Raka]\nHuh?! i think forgot my laptop..",
	"[???]\nOh.. We should help him",
	"[???]\n...Right.\nGo back, Raka.",
	"[Raka]\nWhat?!\n...There's.. no one here..?",
	"[Raka]\n....Must be my imagination",
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


# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(len(dialogues)):
	#	DialogueBoxManager.emit_signal("type", dialogues[i])
	#animator.play("ath-talk")
	pass

var current_dialogue_index = -1
var done = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
		
		
	
func _process(delta):

	if current_dialogue_index < dialogues.size() - 1:
		current_dialogue_index += 1
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		animator.play(expressions[current_dialogue_index])
	
	elif done:
		get_tree().change_scene("res://scenes/pre-levels/transition-1.tscn")

	else:
		done = true


