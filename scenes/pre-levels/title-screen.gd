extends Node2D

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene
export (int) var time

func _ready():
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(time),"timeout")
	$TransitionScreen.change_scene(next_scene)
	pass
