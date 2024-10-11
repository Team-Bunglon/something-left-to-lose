extends CanvasLayer

var isPaused = false
export (String) var next_scene
onready var flavor_text = $Control/MarginContainer/MarginContainer/VBoxContainer/FlavorText
onready var subtitle = $Control/MarginContainer/MarginContainer/VBoxContainer/Subtitle

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = get_tree().get_nodes_in_group("button")
				
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered", [button])
		button.connect("focus_entered", self, "_on_focus_entered", [button])
		button.connect("mouse_exited", self, "_on_button_exited", [button])
		button.connect("focus_exited", self, "_on_focus_exited", [button])
			
	$Options.pause_mode = Node.PAUSE_MODE_PROCESS
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_entered(button):
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$SelectSFX.play()
	
	if button.name == "PlayButton":
		flavor_text.text = "Resume"
		subtitle.text = "Continue your story."
	elif button.name == "OptionsButton":
		flavor_text.text = "Options"
		subtitle.text = "Personalize your experience a little."
	elif button.name == "ExitButton":
		flavor_text.text = "Return to Main Menu"
		subtitle.text = "Leaving already?"
		
	
func _on_button_exited(button):
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	flavor_text.text = ""
	subtitle.text = ""
	
func _on_focus_entered():
	$SelectSFX.play()

func _on_focus_exited():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_pause"):
		if isPaused:
			self.visible = false
			get_tree().paused = false
			isPaused = false
		else:
			self.visible = true
			get_tree().paused = true
			isPaused = true
	
func _on_Options_closed_menu():
	$Control.visible = true
			
func _on_PlayButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		self.visible = false
		get_tree().paused = false
		
func _on_OptionsButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$Control.visible = false
		$Options.visible = true
		
func _on_ExitButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)



