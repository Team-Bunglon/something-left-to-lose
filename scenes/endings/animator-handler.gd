extends AnimatedSprite
export  (String) var scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished():
	get_tree().change_scene(scene)
