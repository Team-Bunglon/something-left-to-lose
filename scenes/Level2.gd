extends Node2D

onready var dialogbox = $dialoguebox

var dialogues = [
	"I think i am done for today.",
	"Sun is getting low, i should head back home soon",
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
	
	PLAYER_STATES.hold_key()
	
	if dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
