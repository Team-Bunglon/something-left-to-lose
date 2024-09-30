extends Control

# Object that can be pick up from [code]ClutterGame[/code] interface and place in the Player's inventory.
class_name Pickable

export var item_name = ""

func _ready():
	DialogueBoxManager.connect("add_item", self, "added_to_inventory")
	if item_name == "full passcode":
		PLAYER_STATES.fullpascode = self
	if item_name == "blurred passcode":
		PLAYER_STATES.blurpasscode = self

# The follow methods are required by any objects that can be taken according to the orignal dev.
func get_texture():
	return $Sprite.texture

# Get item's name as is.
func get_name():
	return name

# Get item's name in lower case. Useful for boolean operation to make dealing with capitalization easier.
func get_lower_name():
	return name.to_lower()

func added_to_inventory(item):
	if item == self:
		visible = false
	
func _on_Sprite_gui_input(event):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			DialogueBoxManager.emit_signal("pick_up", self)
