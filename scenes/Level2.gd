extends Node2D

onready var dialogbox = $dialoguebox
onready var animator = $animate

var dialogues = [
	"I think i am done for today.",
	"Sun is getting low, i should head back home soon",
]
var expressions = [
	"def-neutral",
	"def-neutral",
]
var current_dialogue_index = 0

func _ready():
	$tembok2/doubledoor_1.open()
	$tembok2/doubledoor_2.open()
	$tembok2/doubledoor_3.open()
	$tembok2/doubledoor_4.open()
	$tembok2/doubledoor_5.open()
	$tembok2/doubledoor_6.open()
	$tembok2/doubledoor_7.open()
	$CanvasModulate.visible = true
	
	animator.visible = true
	$tembok2/player/Light2D.visible = false
	
	if dialogues.size() > 0:
		animator.play("def-neutral")
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if current_dialogue_index == 1:
		animator.visible = false
		$tembok2/player/Light2D.visible = true

	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			animator.play(expressions[current_dialogue_index])
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
