extends Node2D
class_name Chapter1Level2

# The path to the next scene after this scene finished playing.
export (String, FILE, "*.tscn") var next_scene

onready var transition_screen = $TransitionScreen
onready var animator = $AnimateLayer/Animate
onready var light = $Wall/Player/Light2D

var dialogues = [
	"I think I am done for the day.",
	"Sun is getting low, I should head back home soon.",
]

var expressions = [
	"def-neutral",
	"def-neutral",
]

var d_index = 0

func _ready():
	$PauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	$CanvasModulate.visible = true
	$AmbienceSFX.play()

func _process(delta):
	if d_index < dialogues.size():
		ExpressionManager.emit_signal("show", expressions[d_index])
		DialogueBoxManager.emit_signal("type", dialogues[d_index])
		d_index += 1
	elif d_index == 2:
		ExpressionManager.emit_signal("hide")
		d_index += 1

	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		$PauseMenu.visible = true
		
func _on_PreChaseCutsceneArea_body_entered(body):
	if body.get_name().to_lower() == "player":
		transition_screen.change_scene(next_scene)
