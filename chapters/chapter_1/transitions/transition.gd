extends Node2D

export (String, FILE, "*.tscn") var next_scene
export (int) var time

func _ready():
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(time),"timeout")
	get_tree().change_scene(next_scene)
