extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var expression
export (String) var dialogue
# Called when the node enters the scene tree for the first time.
func _ready():
	$animate.play(expression)
	DialogueBoxManager.emit_signal("type", dialogue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#
func _process(delta):
	if Input.is_action_pressed("space") or Input.is_action_pressed("enter"):
		queue_free()
