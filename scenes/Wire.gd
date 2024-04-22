extends Area2D

var WireEnd: Sprite
var WireExposed: Sprite
var WireMoving: Area2D
var StartPoint: Vector2

func _ready():
	WireEnd = $WireEnd
	WireExposed = $WireExposed
	StartPoint = position

func _input(event):
	if event is InputEventMouseMotion and event.button_mask == BUTTON_LEFT:
		var new_position = get_global_mouse_position()
		update_wire(new_position)

func update_wire(new_position):
	position = new_position
	var direction = new_position - StartPoint
	rotation = direction.angle()
	
	var dist = StartPoint.distance_to(new_position)
	WireEnd.scale = Vector2(dist / WireEnd.texture.get_size().x, WireEnd.scale.y)
