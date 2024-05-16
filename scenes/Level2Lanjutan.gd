extends Node2D

onready var dialogbox = $dialoguebox

var dialogues = [
	"Huh, What is that cat running from?",
	"\"You feel an evil presence watching you...\"",
	"That cat seems friendly from the looks of it, let's try following the cat to the elevator and leave."
]
var current_dialogue_index = 0

onready var doors = [
	$tembok2/doubledoor_1,
	$tembok2/doubledoor_2,
	$tembok2/doubledoor_3,
	$tembok2/doubledoor_4,
	$tembok2/doubledoor_5,
	$tembok2/doubledoor_6,
	$tembok2/doubledoor_7
]
var door_timer = Timer.new()
var min_time = 1.0
var max_time = 2.0

func _ready():
	$tembok2/doubledoor_1.open()
	$tembok2/doubledoor_2.open()
	$tembok2/doubledoor_3.open()
	$tembok2/doubledoor_4.open()
	$tembok2/doubledoor_5.open()
	$tembok2/doubledoor_6.open()
	$tembok2/doubledoor_7.open()
	
	PLAYER_STATES.hold_key()
	
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.one_shot = false
	door_timer.connect("timeout", self, "_change_door_states")
	add_child(door_timer)
	door_timer.start()
	
	if dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
			
func _change_door_states():
	for door in doors:
		if randi() % 2 == 0:
			door.open()
		else:
			door.close()
	
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.start()
