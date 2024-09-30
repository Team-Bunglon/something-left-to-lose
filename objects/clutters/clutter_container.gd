extends Node2D

# Object that will open the ClutterGame nodes. It doesn't actually store anything. You need to create the ClutterGame manually.
class_name ClutterContainer

signal open

func interact():
	emit_signal("open")
