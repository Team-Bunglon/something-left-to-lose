extends Node2D

signal open_locksafe()
signal open()

export var unlocked = false

func interact():
	if unlocked:
		emit_signal("open")
	else:
		emit_signal("open_locksafe")

func unlock():
	unlocked = true
