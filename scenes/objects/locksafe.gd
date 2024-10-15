extends Node2D

# The usual open signal
signal open()

# The open signal specifically for locksafe UI
signal open_locksafe()

export var unlocked = false

func interact():
	if unlocked:
		emit_signal("open")
	else:
		emit_signal("open_locksafe")

func unlock():
	unlocked = true
