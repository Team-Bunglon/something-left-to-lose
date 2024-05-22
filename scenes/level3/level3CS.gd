extends Node2D

onready var cat = $AnimalCat
onready var cat_anim = cat.get_node("AnimatedSprite")
onready var cat_cam = cat.get_node("CatCam")
onready var enemy = get_node("enemy")
onready var area_list = [$area1,$area2,$area3,$area4,$area5,$area6]
onready var transition = $TransitionScreen1

var move_speed = 100
var arealist_idx = 0
var target_pos = Vector2()


func _ready():
	$doubledorr_hadapsisi.open()
	cat_cam.make_current()
	cat_anim.play("running-right")
	target_pos = Vector2(area_list[arealist_idx].position)
	enemy.visible = false
	
	
func _process(delta):
	cat.set_target_pos(target_pos)

func _on_area1_body_entered(body):
	if body.get_name() == "AnimalCat":
		DialogueBoxManager.emit_signal("lvl3", "That's the cat from before. Why does he keep running?")
		arealist_idx+=1
		target_pos = Vector2(area_list[arealist_idx].position)


func _on_area2_body_entered(body):
	if body.get_name() == "AnimalCat":
		arealist_idx+=1
		target_pos = Vector2(area_list[arealist_idx].position)


func _on_area3_body_entered(body):
	if body.get_name() == "AnimalCat":
		arealist_idx+=1
		target_pos = Vector2(area_list[arealist_idx].position)


func _on_area4_body_entered(body):
	if body.get_name() == "AnimalCat":
		arealist_idx+=1
		target_pos = Vector2(area_list[arealist_idx].position)
		enemy.visible = true
		enemy.is_start = true


func _on_area5_body_entered(body):
	if body.get_name() == "AnimalCat":
		arealist_idx+=1
		target_pos = Vector2(area_list[arealist_idx].position)


func _on_area6_body_entered(body):
	if body.get_name() == "AnimalCat":
		cat.visible = false
		$doubledorr_hadapsisi.close()
		Input.action_press("ui_accept")
		DialogueBoxManager.emit_signal("type", "A pool of blood?! Can't it get any worse?")
		enemy.is_start = false
		cat.visible = false
		transition.change_scene("res://scenes/level3/level3_pregame.tscn")

func _on_area3_body_exited(body):
	if body.get_name() == "AnimalCat" and DialogueBoxManager.is_typing == false:
		DialogueBoxManager.emit_signal("lvl3", "What hit him? Is he running from something... again?")


func _on_area7_body_entered(body):
	if body.get_name() == "AnimalCat":
		Input.action_press("ui_accept")
