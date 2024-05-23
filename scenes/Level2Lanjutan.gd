extends Node2D

onready var player_camera_vignette = get_node("tembok2/player/Camera2D/Vignete")
onready var dialogbox = $dialoguebox
onready var animator = $animate

var dialogues = [
	"[Raka]\nHuh, What is that cat running from?",
	"\"You feel an evil presence watching you...\"",
	"[Raka 2]\nThat cat seems friendly from the looks of it, let's try following the cat to the elevator and leave.",
	"[Raka 3]\nSwitch to me, let me outrun this with ease.\n(Press 3 to switch to athlete persona)"
]
var expressions = [
	"def-neutral",
	"def-neutral",
	"int-smile",
	"ath-neutral"
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
var min_time = 0.5
var max_time = 1.0

func _ready():
	$CanvasModulate.visible = true
	$tembok2/player/AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/ambience-level2lanjutan.mp3")
	$tembok2/player/AudioStreamPlayer2D.play()
	
	$tembok2/player/Light2D.visible = false
	player_camera_vignette.visible = true
	animator.visible = true
	
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.one_shot = false
	door_timer.connect("timeout", self, "_change_door_states")
	add_child(door_timer)
	door_timer.start()
	
	if dialogues.size() > 0:
		animator.play("def-neutral")
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if current_dialogue_index == 3:
		animator.visible = false
		$tembok2/player/Light2D.visible = true
	
	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			animator.play(expressions[current_dialogue_index])
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
			
func _change_door_states():
	for door in doors:
		if randi() % 2 == 0:
			door.open()
		else:
			door.close()
	
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.start()
