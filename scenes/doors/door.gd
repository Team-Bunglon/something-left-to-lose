extends transparancable_object
class_name door

onready var door_closed = $door_closed
onready var door_opened = $door_opened

var status

# Called when the node enters the scene tree for the first time.
func _ready():
	door_closed.visible=true
	door_opened.visible=false
	status = "closed"

func interact():
	print(self)
	if status=="closed":
		open()
	elif status=="opened":
		close()

func open():
	door_closed.visible=false
	door_opened.visible=true
	door_closed.set_collision_layer_bit(0,false)
	status = "opened"

func close():
	var objects = self.get_overlapping_bodies()
	var cannot_close = false
	for o in objects:
		if "player" in o.name:
			cannot_close = true
	if not cannot_close:
		door_closed.visible=true
		door_opened.visible=false
		door_closed.set_collision_layer_bit(0,true)
		status = "closed"
