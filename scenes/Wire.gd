extends Area2D

var WireEnd: Sprite
var WireExposed: Sprite
var WireBody: Sprite
var startPoint : Vector2
var startPosition : Vector2

func _ready():
	WireEnd = $WireEnd
	WireExposed = $WireExposed
	WireBody = $WireBody
	startPoint = get_parent().position
	startPosition = position

func _input(event):
	if event is InputEventMouseMotion and event.button_mask == BUTTON_LEFT:
		var new_position = get_global_mouse_position()
		update_wire(new_position)

func update_wire(new_position):
	position = new_position
	var direction = new_position - startPoint
	rotation = direction.angle()
	var dist = startPoint.distance_to(new_position)

	if WireBody != null and WireBody.texture != null:
		WireEnd.position.x = dist
		WireExposed.position.x = dist + WireEnd.texture.get_width()
