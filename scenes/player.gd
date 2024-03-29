extends KinematicBody2D

onready var ray = $RayCast2D
onready var animated_sprite = $AnimatedSprite

var animation_speed = 20
var moving = false

var ease_move=0
var forced_dir=Vector2.ZERO

var tile_size = 16
# TODO: Kalo player hit > arrow key error
var inputs = {Vector2(1,0): Vector2.RIGHT,
			Vector2(-1,0): Vector2.LEFT,
			Vector2(0,-1): Vector2.UP,
			Vector2(0,1): Vector2.DOWN,
			Vector2(0,0):Vector2.ZERO}
			
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _process(delta):
	if moving:
		ease_move-=delta

func _unhandled_input(event):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	move(input)

func move(dir):
	if moving :
		print("b")
		ease_move = 0.05
		forced_dir = dir
		return
		
	# TODO : Animate WALK
	
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if not moving and ease_move>0:
		print("a")
		if !ray.is_colliding():
			var tween = get_tree().create_tween()
			ease_move=0
			tween.tween_property(self, "position",position + inputs[forced_dir] * tile_size, 1.0/animation_speed)
			yield(tween,"finished")
			forced_dir=Vector2.ZERO
			return
	
	if not moving:
		if !ray.is_colliding():
			moving = true
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position",position + inputs[dir] *    tile_size, 1.0/animation_speed)
			yield(tween,"finished")
			moving = false
		
	open_door()

func open_door():
	var a = $Area2D.get_overlapping_bodies()
	for x in a:
		if x!=null and "door" in x.name and Input.is_action_pressed("ui_accept"):
			x.get_parent().interact()
