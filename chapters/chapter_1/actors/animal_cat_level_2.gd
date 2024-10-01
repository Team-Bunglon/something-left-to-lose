extends KinematicBody2D

# TODO: Make this more modular for different cutscene.
func _process(delta):
	var target_position = Vector2(1320, -230)
	var move_speed = 50
	var current_position = position
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	position.x = new_position.x
