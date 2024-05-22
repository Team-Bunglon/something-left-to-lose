extends KinematicBody2D

export (float) var move_speed = 50.0

onready var target_position = Vector2()
onready var animated_sprite = $AnimatedSprite

var current_position : Vector2

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
