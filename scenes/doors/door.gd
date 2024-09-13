extends transparancable_object

class_name door

onready var door_closed = $door_closed
onready var door_opened = $door_opened

export var is_locked = false
export var permanent_locked = false

var status

# Called when the node enters the scene tree for the first time.
func _ready():
	door_closed.visible=true
	door_opened.visible=false
	status = "closed"

func interact():
	print(self)
	
	if status=="closed" and permanent_locked:
		DialogueBoxManager.emit_signal("type", """The door is locked.
		You don't know if the key even exists.""")
		return
		
	if status=="closed" and !is_locked:
		#DialogueBoxManager.emit_signal("type", "The door is not locked")
		open()
		return
	
	if status=="closed" and is_locked and !PLAYER_STATES.is_holding_key:
		DialogueBoxManager.emit_signal("type", """The door is locked.
		The key is somewhere on the map...""")
		return
	
	if status=="closed" and is_locked and PLAYER_STATES.is_holding_key:
		PLAYER_STATES.drop_key()
		open()
		DialogueBoxManager.emit_signal("type", """You open the door.
		But you've broken the key.""")
		
	elif status=="opened":
		close()

#	DialogueBoxManager.emit_signal("type", "This is a door")

func open():
	$AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/door-opened.mp3")
	$AudioStreamPlayer2D.play()
	
	door_closed.visible=false
	door_opened.visible=true
	door_closed.set_collision_layer_bit(0,false)
	status = "opened"
	is_locked = false

func close():
	$AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/door-closed.mp3")
	$AudioStreamPlayer2D.play()
	
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
