extends Node2D

onready var animal_cat = get_node("AnimalCat")
onready var animated_cat_sprite = animal_cat.get_node("AnimatedSprite")
onready var player_sprite = get_node("player/AnimatedSprite")
onready var prechase_cutscene_area = get_node("PreChaseCutsceneArea/TriggerArea")

var target_position = Vector2(250, -230)
var move_speed = 100

func _ready():
	player_sprite.play("default-side-idle")
	animated_cat_sprite.play("running-right")
	
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	player_sprite.flip_h = true

func _process(delta):
	var current_position = animal_cat.position
	var new_position = current_position.move_toward(target_position, move_speed * delta)
	animal_cat.position.x = new_position.x
	
	if current_position.distance_to(target_position) < 1:
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
	var transition_screen = get_node("TransitionScreen1")
	transition_screen.change_scene("res://scenes/Level2Lanjutan.tscn")
