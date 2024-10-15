extends Node2D

# Item that can be pickable from the overworld when being interacted
class_name PickableOverworld

export (String) var item_name
export (String, MULTILINE) var obtain_message = "You found an item."
export (Texture) var overworld_sprite
export (Texture) var inventory_sprite

var collected = false

func _ready():
	$Item.item_name = item_name
	$Sprite.texture = overworld_sprite
	$Item/Sprite.texture = inventory_sprite

func _collect():
	collected = true
	$Sprite.visible = false

func interact():
	if collected:
		return

	if PLAYER_STATES.items.size() > 4:
		DialogueBoxManager.emit_signal("type", """There's something in here.
		But your inventory is full""")
		return

	# Collect Item
	collected = true
	$Sprite.visible = false
	PLAYER_STATES.add_item($Item)
	DialogueBoxManager.emit_signal("type", obtain_message)
