extends KinematicBody2D

# Enemies encounted during prologue. Based on the original EnemyEntity class. This entity cannot die, you can only run from it.
class_name EnemyPrologue

# The speed of which the enemy moves.
export var speed = 150

# Is it active or not. If [code]false[/code], the enemy will stay on place and cannot hurt the player.
export var is_active = true

onready var player = get_parent().get_node("Player")
onready var sprite = $AnimatedSprite

var player_position
var target_position

func _ready():
	sprite.play("idle")
	if is_active:
		active()
	else:
		inactive()

func active():
	$Hitbox/CollisionShape2D.disabled = false
	$AudioStreamPlayer2D.play()

func inactive():
	$Hitbox/CollisionShape2D.disabled = true

func _physics_process(_delta):
	if not is_active:
		return

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


func _on_Hitbox_body_entered(body:Node):
	if "player" in body.name.to_lower():
		print("Ouch")
		#get_tree().change_scene("res://scenes/Deathscene.tscn")

