extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER_STATES.connect("refresh_inventory",self,"refresh_inventory")


func refresh_inventory(items):
	for child in get_children():
		child.queue_free()
		
	for item in items:
		var new_item = TextureButton.new()
		new_item.disabled=true
		new_item.texture_normal=item.get_texture()
		new_item.texture_disabled = item.get_texture()
		add_child(new_item)
