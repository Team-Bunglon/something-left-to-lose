extends KinematicBody2D

export var speed = 150
var player_position
var target_position
onready var player = get_parent().get_node("Player")
onready var sprite = $AnimatedSprite
onready var smoke_sprite = $SmokeSprite
var lifetime = rand_range(3.0, 6.0)

func _ready():
	sprite.play("idle")
	smoke_sprite.visible = false
	$CollisionShape2D.disabled = false
	$Hitbox/CollisionShape2D.disabled = false
	$AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/ghostbreath.mp3")
	$AudioStreamPlayer2D.play()
	
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.connect("timeout", self, "_on_lifetime_timeout")
	add_child(timer)
	timer.start()

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

func _on_lifetime_timeout():
	$AnimatedSprite.visible = false
	$CollisionShape2D.disabled = true
	$Hitbox/CollisionShape2D.disabled = true
	$Light2D.visible = false
	smoke_sprite.visible = true
	$AnimationPlayer.play("smoke-idle")
	
	var delay_timer = Timer.new()
	delay_timer.wait_time = 0.3
	delay_timer.one_shot = true
	delay_timer.connect("timeout", self, "_on_delay_timeout")
	add_child(delay_timer)
	delay_timer.start()

func _on_delay_timeout():
	smoke_sprite.visible = false
	queue_free()
