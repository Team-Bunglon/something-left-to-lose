extends Control

class_name Key

export var item_name = ""

func _ready():
	DialogueBoxManager.connect("add_item",self,"added_to_inventory")


# method method ini wajib dipunyain object yang bisa di pick up
func get_texture():
	return $Sprite.texture

func get_name():
	return name

func added_to_inventory(item):
	if item == self:
		visible = false
	
func _on_Sprite_gui_input(event):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			DialogueBoxManager.emit_signal("pick_up", self)
