extends Node2D

export (String) var path
export (int) var time

func _ready():
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(time),"timeout")
	get_tree().change_scene("res://scenes/level0/level_0_0.gd")
	pass
