extends Control

const angle_sensitivity = 3

var _is_mouse_hover = false
onready var _angle_offset = randf() * 360

func _ready():
	rect_rotation = rad2deg(rect_global_position.angle()) * angle_sensitivity +_angle_offset

func _process(_delta):
	if SampahManager.dragging_sampah == self:
		rect_global_position = get_global_mouse_position() + SampahManager.offset
		rect_rotation = rad2deg(rect_global_position.angle()) * angle_sensitivity + _angle_offset
			
			

func _on_Sprite_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("click") and !is_instance_valid(SampahManager.dragging_sampah):
			SampahManager.dragging_sampah = self
			SampahManager.offset = rect_global_position - get_global_mouse_position()
		
		if SampahManager.dragging_sampah == self and event.is_action_released("click"):
			SampahManager.dragging_sampah = null


func _on_Sprite_mouse_entered():
	rect_scale = Vector2(1.1, 1.1)


func _on_Sprite_mouse_exited():
	rect_scale = Vector2(1, 1)
