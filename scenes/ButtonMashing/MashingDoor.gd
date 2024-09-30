extends Area2D
class_name MashingDoor

# TODO: There doesn't seem to be any scenes that uses this script.

onready var door_closed = $door_closed
onready var door_opened = $door_opened

var status

# var needed to button mashing door
var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 0.75
var time_passed = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	door_closed.visible=true
	door_opened.visible=false
	status = "closed"

func interact():
	print(self)
	if status=="closed":
		open()
	elif status=="opened":
		close()

func open():
	door_closed.visible=false
	door_opened.visible=true
	door_closed.set_collision_layer_bit(0,false)
	status = "opened"

func close():
	var objects = self.get_overlapping_bodies()
	var cannot_close = false
	for o in objects:
		if "player" in o.name:
			cannot_close = true
	if not cannot_close:
		door_closed.visible=true
		door_opened.visible=false
		door_closed.set_collision_layer_bit(0,true)
		status = "closed"

# adding button mashing mechanic to door
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == button:
		pressCount += 1
		score += 5



