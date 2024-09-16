extends Node2D


export (String) var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = get_tree().get_nodes_in_group("button")
	$PlayButton.grab_focus()
				
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered")
		button.connect("focus_entered", self, "_on_focus_entered")
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_PlayButton_pressed():
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene(next_scene)


func _on_QuitButton_pressed():
	get_tree().quit()
	
func _on_button_entered():
	$SelectSFX.play()
	

func _on_focus_entered():
	$SelectSFX.play()
