extends Node

const level4_preload = preload("res://chapter-2/level-4.tscn")

var level4 : Node = null

func _ready():
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.name == "Level4":
		level4 = current_scene

func show_pawprints():
	level4.show_pawprints()
