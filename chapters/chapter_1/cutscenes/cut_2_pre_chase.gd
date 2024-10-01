extends Node2D

# The path to the next scene after this scene finished playing.
export (String, FILE, "*.tscn") var next_scene

# This codebase isn't that bad. I'm not touching this that much.
onready var animal_cat = get_node("AnimalCat")
onready var animated_cat_sprite = animal_cat.get_node("AnimatedSprite")
onready var cat_audio = get_node("AnimalCat/AudioStreamPlayer2D")
onready var player_sprite = get_node("Player/AnimatedSprite")
onready var player_camera_vignette = get_node("Player/Camera2D/Vignete")
onready var prechase_cutscene_area = get_node("PreChaseCutsceneArea/TriggerArea")
onready	var transition_screen = get_node("TransitionScreen1")

var target_position = Vector2(1432, -232)
var move_speed = 100

func _ready():
	$CanvasModulate.visible = true
	
	player_camera_vignette.visible = false
	player_sprite.play("default-side-idle")
	animated_cat_sprite.play("running-right")

	var timer = Timer.new()
	timer.wait_time = 1.5
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	player_sprite.flip_h = true
	cat_audio.play()
	
	var reset_timer = Timer.new()
	reset_timer.wait_time = 1.5
	reset_timer.one_shot = true
	add_child(reset_timer)
	reset_timer.start()
	reset_timer.connect("timeout", self, "_reset_player_sprite_flip_h")

func _reset_player_sprite_flip_h():
	player_sprite.flip_h = false

func _process(delta):
	var current_position = animal_cat.position
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	animal_cat.position.x = new_position.x
	
	if current_position.distance_to(target_position) < 10:
		animated_cat_sprite.flip_h = true
		animated_cat_sprite.play("idle")
		start_scene_change_timer()

func start_scene_change_timer():
	var scene_change_timer = Timer.new()
	scene_change_timer.wait_time = 2.0
	scene_change_timer.one_shot = true
	add_child(scene_change_timer)
	scene_change_timer.start()
	scene_change_timer.connect("timeout", self, "_on_Scene_Change_Timer_timeout")

func _on_Scene_Change_Timer_timeout():
	transition_screen.change_scene(next_scene)
