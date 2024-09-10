extends Node2D

export (String) var path
export (int) var time

func _ready():
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(time),"timeout")
	return get_tree().change_scene(path)
