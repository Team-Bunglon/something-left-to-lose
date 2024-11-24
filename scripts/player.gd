extends KinematicBody2D
class_name Player


# Export var should be on top.
export var stamina :int = 10

## Disable manual personality switch from the player's input. Used for chapter 0 (prologue).
export var disable_switch = false

# Default facing direction. Note that the default "side" looks at right.
export(String, "front", "side", "side-flip", "back") var start_dir = "front"

# Use the new directional interaction where the player character actually has to look at the interactible, not by just standing next to it while looking at any direction. This is not enabled by default to not break the old placement of interactible trigger.
export var use_directional_interaction = false

onready var ray = $RayCast2D
onready var animated_sprite = $AnimatedSprite
onready var player_cam = $Camera2D
onready var current_state_label = $Label # What is this used for?
var current_scene = ""
var camera_tween: SceneTreeTween = null

var animation_speed = 7
var switch_cd = 1.0
var can_switch = true

# To control wheather the player can move or not (e.g. opening a trash bin shouldn't let the player move)
var is_active = true
var moving = false
var current_state = PLAYER_STATES.STATES.DEFAULT
var ease_move = 0
var forced_dir = Vector2.ZERO
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

# Treat this like a stack, where the character only cares about the last input.
var direction_stack = []

var key_is_pressed = false

func _ready():
	current_scene = get_tree().current_scene
	play_idle(start_dir)
	set_interact_trigger(inputs[dir_dic[start_dir]])

	position = position.snapped(Vector2.ONE * tile_size) # So this is how do you do per-tile movement. Interesting...
	position += Vector2.ONE * tile_size / 2

	current_state_label.text = str(current_state)

	if use_directional_interaction:
		$PlayerInteract.show()
		$PlayerInteract/CollisionShape2D.show()
		$PlayerInteract/CollisionShape2D.disabled = false
	else:
		$PlayerInteract.hide()
		$PlayerInteract/CollisionShape2D.hide()
		$PlayerInteract/CollisionShape2D.disabled = true


func _process(delta):
	move(delta)
	switch()

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if not dir in direction_stack:
				direction_stack.append(dir)
			debug_move(dir)
		if event.is_action_released(dir):
			direction_stack.erase(dir)
			debug_hide(dir)

func move(delta):
	if moving:
		ease_move-=delta
	elif is_active:
		key_is_pressed = false
		for dir in inputs.keys():
			if dir != "stand" and Input.is_action_pressed(dir) and not direction_stack.empty():
				key_is_pressed = true
				last_dir = direction_stack[direction_stack.size() - 1]
				step(last_dir)
		if not key_is_pressed:
			animate_movement(last_dir, current_state, false)
			direction_stack = []
			for dir in inputs.keys():
				debug_hide(dir)

func debug_move(dir):
	if dir == "up":
		$Debug/U.show()
	elif dir == "down":
		$Debug/D.show()
	elif dir == "left":
		$Debug/L.show()
	elif dir == "right":
		$Debug/R.show()

func debug_hide(dir):
	if dir == "up":
		$Debug/U.hide()
	elif dir == "down":
		$Debug/D.hide()
	elif dir == "left":
		$Debug/L.hide()
	elif dir == "right":
		$Debug/R.hide()

func step(dir):
	if moving:
		ease_move = 0.01
		forced_dir = dir
		return
	
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	set_interact_trigger(inputs[dir])

	if not moving and ease_move > 0:
		if !ray.is_colliding():
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
		else:
			animate_movement(dir, current_state, false)

func set_interact_trigger(dir:Vector2):
	$PlayerInteract.position = dir * tile_size
	return

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
	if can_switch:
		for state in states.keys():
			if Input.is_action_pressed(state) and current_state!=states[state] and is_active and not disable_switch:
				can_switch = false
				switch_procedure(state)
				yield(get_tree().create_timer(switch_cd), "timeout")
				can_switch = true
				

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
	#if stamina==0:
		#self.queue_free()
		
	if current_state == 1 and current_scene.name == "baselevel":
		PLAYER_STATES.check_paper_count()
		
	if current_state == 1 and current_scene.name == "Level4":
		Level4Manager.show_pawprints()

# Stop the player from controling the player character and play its idle animation
func inactive():
	is_active = false
	idle(last_dir, current_state)

# Alias to player.is_active = true
func active():
	is_active = true

# Refocus the camera to the player
func refocus_camera():
	$Camera2D.current = true

# Get the player's camera global position
func get_camera_position():
	return $Camera2D.global_position

# Manually play idle sprite through code or animation player. The options are exactly the same as start dir: "front", "side", "side-flip", and "back"
func play_idle(dir: String):
	var state = state_dic[current_state]
	last_dir = dir_dic[dir]
	idle(last_dir, current_state)
	if dir != "side-flip":
		animated_sprite.play(state + "-" + dir + "-idle")
	else:
		animated_sprite.play(state + "-side-idle")
		animated_sprite.flip_h = true
	
# This is literally the same as above. Choose whatever suits the current scenario I guess.
func make_player_idle():
	is_active = false
	if current_state == PLAYER_STATES.STATES.DEFAULT:
		animated_sprite.play("default-side-idle")
	elif current_state == PLAYER_STATES.STATES.SMART:
		animated_sprite.play("intel-side-idle")
	else:
		animated_sprite.play("athlete-side-idle")

func shake_camera(intensity: float, duration: float):
	camera_tween = get_tree().create_tween()
	camera_tween.tween_property(player_cam, "offset", Vector2(randf() * intensity, randf() * intensity), duration / 2)
	yield(camera_tween, "finished")
	camera_tween.tween_property(player_cam, "offset", Vector2.ZERO, duration/2)
	yield(camera_tween, "finished")
	
func stop_camera_shake():
	if camera_tween:
		camera_tween.stop()
	
	player_cam.offset = Vector2.ZERO
