extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var next_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(6.0),"timeout")
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene(next_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
