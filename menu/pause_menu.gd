extends CanvasLayer

export (String) var next_scene

func _ready():
	var buttons = get_tree().get_nodes_in_group("button")
				
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered")
		button.connect("focus_entered", self, "_on_focus_entered")
			
	$Options.pause_mode = Node.PAUSE_MODE_PROCESS
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS


func _on_button_entered():
	$SelectSFX.play()

func _on_PlayButton_pressed():
	self.visible = false
	get_tree().paused = false

func _on_OptionsButton_pressed():
	$Control.visible = false
	$Options.visible = true
	
func _on_Options_closedMenu():
	$Control.visible = true

func _on_QuitButton_pressed():
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene(next_scene)
