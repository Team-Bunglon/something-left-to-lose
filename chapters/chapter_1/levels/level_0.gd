extends Node2D

onready var player_cam = get_node("tembok2/Player/Camera2D")
onready var vending_machinge = $tembok2/vending_machine
onready var transition = $TransitionScreen1

var has_triggered_follow = false

## The path to the next scene after this scene finished playing.
export (String) var next_scene

func _ready():
	player_cam.set_zoom(Vector2(0.15,0.15))
	vending_machinge.get_node("line_wrapper").visible = false
	vending_machinge.get_node("interact_trigger").visible = false

func _on_Area2DFollow_body_entered(body:Node):
	if body.name == "Player" and not has_triggered_follow:
		has_triggered_follow = true
		DialogueBoxManager.emit_signal("type", "Is somebody following me?")

func _on_Area2DTransition_body_entered(body:Node):
	if body.name == "Player":
		get_tree().change_scene(next_scene)
