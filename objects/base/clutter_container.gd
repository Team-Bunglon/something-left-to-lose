extends Node2D

# Object that will open the ClutterGame nodes.
class_name ClutterContainer

signal open

func interact():
	emit_signal("open")
