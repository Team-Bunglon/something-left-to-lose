extends Node2D

onready var player_anim = get_node("player/AnimatedSprite")
onready var cat = $AnimalCat
onready var cat_anim = cat.get_node("AnimatedSprite")
onready var cat_cam = cat.get_node("CatCam")
onready var enemy = get_node("enemy")
onready var food_list = [$food3, $food2]

var move_speed = 100
var idx = 0
var target_pos = Vector2()
var final_dia_called = false

func _ready():
	$doubledorr_hadapsisi.open()
	cat_cam.make_current()
	cat_anim.play("running-right")
	target_pos = Vector2(food_list[idx].position)
	player_anim.play("default-front-idle")
	DialogueBoxManager.emit_signal("type", "A BLACKOUT??? I WAS JUST HAPPY TO FINALLY SEE SOME LIGHTS!")

func _process(delta):
	cat.set_target_pos(target_pos)
	if cat.position == food_list[idx].position:
		target_pos = Vector2(food_list[idx + 1].position)
		DialogueBoxManager.emit_signal("lvl3", "Hmmm the smell... So delicious.")
	if cat.position == food_list[idx + 1].position:
		enter_btn()
		target_pos = Vector2($player.position)
	if cat.position == $player.position and not final_dia_called:
		trigger_final_dia()

func enter_btn():
	Input.action_press("ui_accept")

func trigger_final_dia():
	final_dia_called = true
	final_dia()

func final_dia():
	DialogueBoxManager.emit_signal("type", "I got overwhelmed from today's nonsense. I think I really need to find those foods.")
	$TransitionScreen1.change_scene("res://scenes/level3/level3.tscn")
