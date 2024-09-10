extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene("res://scenes/pre-levels/opening.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
