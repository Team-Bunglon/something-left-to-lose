extends KinematicBody2D

onready var target_position = Vector2()
export (float) var move_speed = 50.0

var current_position : Vector2
var animated_sprite = 

func _ready():
	current_position = position

func _process(delta):
	move_toward_target(delta)

func move_toward_target(delta):
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	position = new_position
	current_position = new_position
	if target_position.x > current_position.x:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
