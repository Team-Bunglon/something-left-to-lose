extends KinematicBody2D

export var speed = 50
var player_position
var target_position
onready var player = get_parent().get_node("player")
onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("idle")

func _physics_process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		move_and_slide(target_position * speed)
		_update_sprite_direction()

func _update_sprite_direction():
	var direction = player_position - position
	
	if direction.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	rotation = 0
