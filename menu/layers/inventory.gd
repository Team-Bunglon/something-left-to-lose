extends Control

func _ready():
	PLAYER_STATES.connect("refresh_inventory" ,self, "refresh_inventory")

func refresh_inventory(items):
	for child in $VBoxContainer.get_children():
		child.queue_free()
		
	for item in items:
		var new_item = TextureButton.new()
		new_item.disabled=true
		new_item.texture_normal=item.get_texture()
		new_item.texture_disabled = item.get_texture()
		new_item.rect_size = Vector2(110, 110)
		new_item.rect_min_size = Vector2(110, 110)
		new_item.expand = true
		new_item.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		$VBoxContainer.add_child(new_item)
