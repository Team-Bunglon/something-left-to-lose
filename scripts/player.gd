extends KinematicBody2D
class_name Player


# Export var should be on top.
export var stamina :int = 10

## Disable manual personality switch from the player's input. Used for chapter 0 (prologue).
export var disable_switch = false

# Default facing direction. Note that the default "side" looks at right.
export(String, "front", "side", "side-flip", "back") var start_dir = "front"

onready var ray = $RayCast2D
onready var animated_sprite = $AnimatedSprite
onready var current_state_label = $Label # What is this used for?

var animation_speed = 7

# To control wheather the player can move or not (e.g. opening a trash bin shouldn't let the player move)
var is_active = true
var moving = false
var current_state = PLAYER_STATES.STATES.DEFAULT
var ease_move=0
var forced_dir=Vector2.ZERO
var last_dir = "down"
var tile_size = 16

var dir_dic = { "front": "down",
				"side": "right",
				"side-flip": "left",
				"back": "up"}

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN,
			"stand" : Vector2.ZERO}

var states = {"1": PLAYER_STATES.STATES.DEFAULT,
			"2": PLAYER_STATES.STATES.SMART,
			"3": PLAYER_STATES.STATES.STRONG}

var state_dic = {PLAYER_STATES.STATES.DEFAULT:"default",
				PLAYER_STATES.STATES.SMART:"intel",
				PLAYER_STATES.STATES.STRONG:"athlete"}

func _ready():
	if start_dir != "side-flip":
		animated_sprite.play("default-" + start_dir + "-idle")
		print("default-" + start_dir + "-idle")
	else:
		animated_sprite.play("default-side-idle")
		animated_sprite.flip_h = true

	last_dir = dir_dic[start_dir]

	position = position.snapped(Vector2.ONE * tile_size) # So this is how do you do per-tile movement. Interesting...
	position += Vector2.ONE * tile_size / 2

	current_state_label.text = str(current_state)

func _process(delta):
	print(is_active)
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
		idle(dir, state)

func idle(dir, state):
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
		if Input.is_action_pressed(state) and current_state!=states[state] and is_active and not disable_switch:
			switch_procedure(state)

# Use this function to switch state by code or during cutscene. The state must be a string or integer of the following: 1 (normal), 2 (smart), 3 (strong).
func switch_immediately(state):
	if not (state in [1, 2, 3] or state in ["1", "2", "3"]):
		assert(false, "The player state for switch function should be 1, 2, or 3")
	switch_procedure(str(state))

func switch_procedure(state):
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

# Stop the player from controling the player character and play its idle animation
func inactive():
	is_active = false
	idle(last_dir, current_state)

# Alias to player.is_active = true
func active():
	is_active = true
