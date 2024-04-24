extends KinematicBody2D

export var speed = 100

var velocity = Vector2.ZERO
onready var navAgent = $NavigationAgent2D
onready var player = get_parent().get_node("player")
var did_arrive = false

func _physics_process(delta):
	navAgent.set_target_location(player.position)
#	print(global_position)
	move_to_target()
		
func move_to_target():
	var move_dir = position.direction_to(navAgent.get_next_location())
	velocity = move_dir*speed
	navAgent.set_velocity(velocity)
	if did_arrive:
		velocity = Vector2.ZERO
	if not did_arrive or not arrived_at_location():
		velocity = move_and_slide(velocity)
	elif not did_arrive:
		did_arrive = true
	if global_position.y >= 523:
		did_arrive = true

func arrived_at_location():
	return navAgent.is_navigation_finished()
