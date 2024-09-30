extends Control

# Items that can be dragged by the mouse. Usually used for trash that cover the target item.
class_name ClutterItem

const angle_sensitivity = 3

var _is_mouse_hover = false
onready var _angle_offset = randf() * 360

func _ready():
	rect_rotation = rad2deg(rect_global_position.angle()) * angle_sensitivity +_angle_offset

func _process(_delta):
	if ClutterManager.current_item == self:
		rect_global_position = get_global_mouse_position() + ClutterManager.offset
		rect_rotation = rad2deg(rect_global_position.angle()) * angle_sensitivity + _angle_offset
			
func _on_Sprite_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("click") and not is_instance_valid(ClutterManager.current_item):
			ClutterManager.offset = rect_global_position - get_global_mouse_position()
			ClutterManager.current_item = self
		
		if ClutterManager.current_item == self and event.is_action_released("click"):
			ClutterManager.current_item = null

func _on_Sprite_mouse_entered():
	rect_scale = Vector2(1.1, 1.1)

func _on_Sprite_mouse_exited():
	rect_scale = Vector2(1, 1)
