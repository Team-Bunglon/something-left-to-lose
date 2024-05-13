extends KinematicBody2D

export var speed = 100

var velocity = Vector2.ZERO
onready var navAgent = $NavigationAgent2D
onready var player = get_parent().get_node("player")
onready var light = get_parent().get_node("player").get_node("Light2D")
var did_arrive = false
onready var canvasbg = get_parent().get_node("CanvasModulate")
onready var timer = $Timer


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


func _on_Area2D_body_entered(body):
	var player_stamina = PLAYER_STATES.stamina
	print(body.name)
	if body.name == "player":
		light.set_color(Color(0.545098, 0, 0, 1))
		yield(get_tree().create_timer(0.3), "timeout")
		light.set_color(Color(0.686275,0.752941,0.760784,1))
		PLAYER_STATES.decrease_stamina(player_stamina-1)
		
