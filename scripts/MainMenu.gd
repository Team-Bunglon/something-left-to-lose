extends Node2D


export (String) var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_PlayButton_pressed():
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene(next_scene)


func _on_QuitButton_pressed():
	get_tree().quit()
