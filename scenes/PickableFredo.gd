extends Control

class_name PickableFredo

export var item_name = ""

func _ready():
	DialogueBoxManager.connect("add_item",self,"added_to_inventory")
	if item_name == "full passcode":
		PLAYER_STATES.fullpascode = self
	if item_name == "blurred passcode":
		PLAYER_STATES.blurpasscode = self


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
