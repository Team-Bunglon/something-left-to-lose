extends Node2D

onready var player_cam = get_node("player/Camera2D")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
