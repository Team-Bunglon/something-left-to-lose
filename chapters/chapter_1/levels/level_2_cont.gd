extends Node2D

onready var chase_bgm = get_node("Wall/Player/AudioStreamPlayer2D")
onready var pause_menu = $PauseMenu

onready var doors = [
	$Wall/DoubleDoor1,
	$Wall/DoubleDoor2,
	$Wall/DoubleDoor3,
	$Wall/DoubleDoor4,
	$Wall/DoubleDoor5,
	$Wall/DoubleDoor6,
	$Wall/DoubleDoor7,
]

var dialogues = [
	"[Raka]\nHuh, What is that cat running from?",
	"\"You feel an evil presence watching you...\"",
	"[Smart Raka]\nThat cat seems friendly from the looks of it, let's try following the cat to the elevator and leave.",
	"[Strong Raka]\nSwitch to me, let me outrun this with ease.\n(Press 3 to switch to Athlete persona)",
	"[Smart Raka]\n*Chuckles* Switch to me if you're too braindead and don't know how to operate the elevator.\n(Press 2 to switch to Intelligent persona)",
]

var expressions = [
	"def-neutral",
	"none",
	"int-smile",
	"ath-neutral",
	"int-smile",
]

var door_timer = Timer.new()
var min_time = 0.5
var max_time = 1.0
var d_index = 0

func _ready():
	$CanvasModulate.visible = true
	$Wall/Player.enable_vignette = true
	$Wall/Player/AudioStreamPlayer2D.play()

	pause_menu.pause_mode = Node.PAUSE_MODE_PROCESS
	chase_bgm.pause_mode = Node.PAUSE_MODE_PROCESS
	
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.one_shot = false
	door_timer.connect("timeout", self, "_change_door_states")

	add_child(door_timer)
	door_timer.start()

func _process(_delta):
	if d_index < dialogues.size():
		ExpressionManager.emit_signal("show", expressions[d_index])
		DialogueBoxManager.emit_signal("type", dialogues[d_index])
		d_index += 1
	elif d_index == dialogues.size():
		ExpressionManager.emit_signal("hide")
		d_index += 1
	
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		pause_menu.visible = true
			
func _change_door_states():
	for door in doors:
		if randi() % 2 == 0:
			door.open()
		else:
			door.close()
	door_timer.wait_time = rand_range(min_time, max_time)
	door_timer.start()
