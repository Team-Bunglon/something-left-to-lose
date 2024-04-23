extends KinematicBody2D

func _ready():
	pass

func _process(delta):
	$AnimatedSprite.play("running-right")
	var target_position = Vector2(1320, -230)
	var move_speed = 50
	var current_position = position
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	position.x = new_position.x
