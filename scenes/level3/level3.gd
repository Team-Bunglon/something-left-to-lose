extends Node2D

onready var dialogbox = $dialoguebox

var dialogues = [
	"What's now? Get some foods, got energized, then?",
	"Hmmm... Where did the cat go? Is the door really closed? Is there still that blood pool?",
	"I really hope the door's not getting locked accidentally",
	"Whatever..."
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
		

