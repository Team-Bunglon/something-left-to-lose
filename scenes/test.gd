extends Node2D

# Please ignore this. This is just to test out gdscripts code (a.k.a. Playground)
var something = "5"

func _ready():
	if typeof(something) == TYPE_STRING:
		print(something + " is a string")
	elif typeof(something) == TYPE_INT:
		print(str(something) + " is an integer")
	print(str(1))
	print(str("1"))
	pass
