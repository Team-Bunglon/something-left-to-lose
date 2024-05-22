extends KinematicBody2D

export var speed = 50

var velocity = Vector2.ZERO
onready var navAgent = $NavigationAgent2D
onready var cat = get_parent().get_node("AnimalCat")
onready var light = get_parent().get_node("AnimalCat").get_node("Light2D")
var did_arrive = false
var is_start = false
onready var canvasbg = get_parent().get_node("CanvasModulate")
onready var timer = $Timer

func _physics_process(delta):
	navAgent.set_target_location(cat.position)
#	print(global_position)
	
	if is_start == true:
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


func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "AnimalCat":
		light.set_color(Color(0.545098, 0, 0, 1))
		yield(get_tree().create_timer(0.3), "timeout")
		light.set_color(Color(0.686275,0.752941,0.760784,1))
		
