extends KinematicBody2D

onready var ray = $RayCast2D
onready var animated_sprite = $AnimatedSprite

var animation_speed = 7
var moving = false

var ease_move=0
var forced_dir=Vector2.ZERO

var tile_size = 16
# TODO: Kalo player hit > arrow key error
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN,
			"stand" : Vector2.ZERO}
			

# untuk mengontrol player bisa berjalan atau tidak. (ex: buka kotak sampah player tidak bisa gerak)
var is_active = true

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _process(delta):
	if moving:
		ease_move-=delta
	elif is_active:
		for dir in inputs.keys():
			if dir!="stand" and Input.is_action_pressed(dir):
				move(dir)

func move(dir):
	if moving :
		ease_move = 0.01
		forced_dir = dir
		return
		
	# TODO : Animate WALK
	
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if not moving and ease_move>0:
		if !ray.is_colliding():
			var tween = get_tree().create_tween()
			ease_move=0
			tween.tween_property(self, "position",position + inputs[forced_dir] * tile_size, 1.0/animation_speed)
			yield(tween,"finished")
			forced_dir="stand"
			return
	
	if not moving:
		if !ray.is_colliding():
			moving = true
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position",position + inputs[dir] *    tile_size, 1.0/animation_speed)
			yield(tween,"finished")
			moving = false
