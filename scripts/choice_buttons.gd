extends CanvasLayer

onready var buttons = get_tree().get_nodes_in_group("button")

func _ready():
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered", [button])
		button.connect("focus_entered", self, "_on_focus_entered", [button])
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS

func _on_button_entered(button):
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	$SelectSFX.play()
	
func _on_button_exited(button):
	button.mouse_default_cursor_shape = Control.CURSOR_ARROW
