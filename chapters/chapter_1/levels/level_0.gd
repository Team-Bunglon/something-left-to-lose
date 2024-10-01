extends Node2D
class_name Chapter1Level0

## The path to the next scene after this scene finished playing.
export (String, FILE, "*.tscn") var next_scene

onready var player_cam = $Wall/Player/Camera2D
onready var transition = $TransitionScreen1

var follow_dialogue = false

func _ready():
	player_cam.set_zoom(Vector2(0.15,0.15))

func _process(_delta):
	if follow_dialogue and $Area2DFollow.monitoring: # I tried using signal but it didn't work
		ExpressionManager.emit_signal("hide")
		$Area2DFollow.monitoring = false

func _on_Area2DFollow_body_entered(body:Node):
	if body.name == "Player" and not follow_dialogue:
		follow_dialogue = true
		ExpressionManager.emit_signal("show", "def-shocked")
		DialogueBoxManager.emit_signal("type", "[Raka]\nIs someone following me?")

func _on_Area2DTransition_body_entered(body:Node):
	if body.name == "Player":
		get_tree().change_scene(next_scene)
