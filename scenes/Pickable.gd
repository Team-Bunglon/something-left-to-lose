extends Node
class_name Pickable

func _ready():
	DialogueBoxManager.connect("add_item",self,"added_to_inventory")

func added_to_inventory(item):
	if item == self.get_parent():
		self.get_parent().queue_free()

func _on_pickable_trigger_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.doubleclick):
		print("double clicked _on_pickable_trigger_input_event")
		DialogueBoxManager.emit_signal("pick_up", self.get_parent())