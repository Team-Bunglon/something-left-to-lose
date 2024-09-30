extends KinematicBody2D
class_name Player

onready var ray = $RayCast2D
onready var animated_sprite = $AnimatedSprite
onready var current_state_label = $Label

var animation_speed = 7

# Allows the player to move. Set it to [code]false[/code] when opening a menu or mini window during gameplay (e.g. opening trash can).
var is_active = true
var moving = false

var current_state = PLAYER_STATES.STATES.DEFAULT

var ease_move=0
var forced_dir=Vector2.ZERO
var last_dir = "down"

export var stamina :int = 10

var tile_size = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN,
			"stand" : Vector2.ZERO}

var states = {"1": PLAYER_STATES.STATES.DEFAULT,
			"2": PLAYER_STATES.STATES.SMART,
			"3": PLAYER_STATES.STATES.STRONG}

func _ready():
	animated_sprite.play("default-front-idle")
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

	current_state_label.text = str(current_state)

func _process(delta):
	move(delta)
	switch()

func move(delta):
	if moving:
		ease_move-=delta
	elif is_active:
		var key_is_pressed=false
		for dir in inputs.keys():
			if dir!="stand" and Input.is_action_pressed(dir):
				key_is_pressed=true
				last_dir=dir
				step(dir)
		if not key_is_pressed:
			animate_movement(last_dir, current_state, false)

func step(dir):
	if moving:
		ease_move = 0.01
		forced_dir = dir
		return
	
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()

	if not moving and ease_move > 0:
		if !ray.is_colliding():
			print(ray.get_co)
			var tween = get_tree().create_tween()

			ease_move=0
			animate_movement(forced_dir, current_state, true)
			tween.tween_property(self, "position",position + inputs[forced_dir] * tile_size, 1.0 / animation_speed)
			yield(tween,"finished")
			forced_dir="stand"
			return

	if not moving:
		if !ray.is_colliding():
			moving = true
			animate_movement(dir, current_state, true)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0 / animation_speed)
			yield(tween, "finished")
			moving = false


func animate_movement(dir, state, is_moving):
	var state_dic = {PLAYER_STATES.STATES.DEFAULT:"default", PLAYER_STATES.STATES.STRONG:"athlete", PLAYER_STATES.STATES.SMART:"intel"}
	if is_moving:
		if dir=="left":
			animated_sprite.play(state_dic[state]+"-side-walk")
			animated_sprite.flip_h=true
		elif dir =="right":
			animated_sprite.play(state_dic[state]+"-side-walk")
			animated_sprite.flip_h=false
		elif dir =="down":
			animated_sprite.play(state_dic[state]+"-front-walk")
		elif dir == "up":
			animated_sprite.play(state_dic[state]+"-back-walk")
	else:
		if dir=="left":
			animated_sprite.play(state_dic[state]+"-side-idle")
			animated_sprite.flip_h=true
		elif dir =="right":
			animated_sprite.play(state_dic[state]+"-side-idle")
			animated_sprite.flip_h=false
		elif dir =="down":
			animated_sprite.play(state_dic[state]+"-front-idle")
		elif dir == "up":
			animated_sprite.play(state_dic[state]+"-back-idle")

func switch():
	for state in states.keys():
		if Input.is_action_pressed(state) and current_state!=states[state]:
			current_state = states[state]
			PLAYER_STATES.setState(states[state])
			current_state_label.text = str(current_state)
			
			if current_state==2:
				animation_speed=10
			else:
				animation_speed=7
			stamina-=1
			PLAYER_STATES.decrease_stamina(stamina)
			if stamina==0:
				self.queue_free()
				
			if current_state == 1:
				PLAYER_STATES.check_paper_count()
