extends Node2D

onready var player_cam = get_node("tembok2/Static Player/Camera2D")
onready var vending_machinge = $tembok2/vending_machine
onready var transition = $TransitionScreen1

func _ready():
	DialogueBoxManager.emit_signal("lvl1", "Press SPACEBAR to start \nor click the NOTICE in the top-right to see Movement Guide")
	player_cam.set_zoom(Vector2(0.15,0.15))
	vending_machinge.get_node("line_wrapper").visible = false
	vending_machinge.get_node("interact_trigger").visible = false


func _on_Area2D3_body_exited(body):
	if body.name == "Static Player":
		get_tree().change_scene("res://scenes/pre-levels/transition-1.tscn")

func _on_Area2D2_body_exited(body):
	if body.name == "Static Player":
		get_tree().change_scene("res://scenes/pre-levels/transition-1.tscn")

func _on_Area2D_body_exited(body):
	if body.name == "Static Player":
		get_tree().change_scene("res://scenes/pre-levels/transition-1.tscn")


func _on_Area2D_body_entered(body):
	if body.name == "Static Player":
		DialogueBoxManager.emit_signal("type", "Is someone following me?")


func _on_Area2D3_body_entered(body):
	if body.name == "Static Player":
		DialogueBoxManager.emit_signal("type", "Is someone following me?")


func _on_Area2D2_body_entered(body):
	if body.name == "Static Player":
		DialogueBoxManager.emit_signal("type", "Is someone following me?")
