extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var path
export (int) var time

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(time),"timeout")
	get_tree().change_scene(path)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
