extends Node2D

onready var dialogbox = $dialoguebox

var dialogues = [
	"It's very dark here in this canteen, all the lights are off. You must get out of here carefully.",
	"Beware of negative thoughts that may come into your mind. It can really damage your stamina.",
	"Those negative thoughts are always chasing you.",
	"Be quick, use your ability, and eat to open the door."
]
var current_dialogue_index = 0

func _ready():
	print(PLAYER_STATES.stamina)
	if Level3Manager.first_time:
		if dialogues.size() > 0:
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if PLAYER_STATES.stamina <= 0:
		Level3Manager.first_time = false
		PLAYER_STATES.decrease_stamina(10)
		get_tree().change_scene("res://scenes/level3/level3.tscn")
	if Level3Manager.first_time and Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		

