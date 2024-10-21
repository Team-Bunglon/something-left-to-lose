extends Sprite

# Objects that don't need its own scene. Doesn't have its own collision.
class_name MiscObject

# Texture to show
export (Texture) var overworld_sprite

func _ready():
	self.texture = overworld_sprite

