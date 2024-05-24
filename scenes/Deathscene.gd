extends Node2D

func _ready():
	$AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/deathsound.mp3")
	$AudioStreamPlayer2D.play()
