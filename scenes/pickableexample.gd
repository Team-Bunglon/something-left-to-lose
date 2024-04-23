extends Node2D

export var item_name = ""
# method method ini wajib dipunyain object yang bisa di pick up
func get_texture():
	return $Sprite.texture

func get_name():
	return name
