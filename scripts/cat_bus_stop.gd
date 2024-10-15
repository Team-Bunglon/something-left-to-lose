extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	var target_position = Vector2(585, 761)
	var move_speed = 150
	var current_position = position
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	position.x = new_position.x
	
