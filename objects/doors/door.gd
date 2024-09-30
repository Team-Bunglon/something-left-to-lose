extends Area2D
class_name door

# Can only be opened when the player has a key in his inventory.
export var is_locked = false

# Make the door be locked forever.
export var permanent_locked = false

# Message to appear when [code]permanent_locked[/code] is enabled.
export(String, MULTILINE) var locked_message = "The door is locked.\nYou don't know if the key even exists."

onready var door_closed = $Closed
onready var door_opened = $Opened

# The current condition of the door: opened or closed
var status
enum {OPENED, CLOSED}

func _ready():
	door_closed.visible=true
	door_opened.visible=false
	status = CLOSED

func interact():
	print(self)
	if status == CLOSED and permanent_locked:
		DialogueBoxManager.emit_signal("type", locked_message)
		return
		
	if status == CLOSED and not is_locked:
		open()
		return
	
	if status == CLOSED and is_locked and not PLAYER_STATES.is_holding_key:
		DialogueBoxManager.emit_signal("type", """The door is locked.
		The key must be somewhere around here...""")
		return
	
	if status == CLOSED and is_locked and PLAYER_STATES.is_holding_key:
		PLAYER_STATES.drop_key()
		open()
		DialogueBoxManager.emit_signal("type", """You open the door.
		But you've broken the key.""")
		
	elif status == OPENED:
		close()

func open():
	$OpenSFX.play()
	
	door_closed.visible=false
	door_opened.visible=true
	door_closed.set_collision_layer_bit(0, false)
	status = OPENED
	is_locked = false

func close():
	$CloseSFX.play()
	
	var objects = self.get_overlapping_bodies()
	var cannot_close = false
	for o in objects:
		if "player" in o.name.to_lower():
			cannot_close = true
	if not cannot_close:
		door_closed.visible=true
		door_opened.visible=false
		door_closed.set_collision_layer_bit(0, true)
		status = CLOSED
