extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueBoxManager.connect("add_item",self,"add_item")

func add_item(item):
	print("add_item"+str(item))
	var new_item = TextureButton.new()
	new_item.disabled=true
	new_item.texture_normal=item.get_texture()
	new_item.texture_disabled = item.get_texture()
	add_child(new_item)
	get_tree().paused=false