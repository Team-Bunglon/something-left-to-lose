#
# Ini berfungsi sebagai sub instance dari suatu instance yang interactable
#

extends Node

# The message that the object will show when interacting. If not set, the object will try to trigger the [code]interact()[/code] function of the parent.
export(String, MULTILINE) var message

# emit "open" signal by itself instead of relying on the parent's [code]interact()[/code] function.
export var self_interact = false

# Show the text or prompt when the player is near an interactible object.
export var show_interact_message = true

# How many seconds the interactible should be delayed until the interactible can be interacted again. This will be ignored when the player moves away and take a look back.
export var interact_delay = 0.0

onready var icon_holder = $icon_holder
onready var interact_icon = $icon_holder/InteractIcon

var interactable = false
var player_inside = false

signal open

func _ready():
	icon_holder.visible = false
	if message == null or message == "Null":
		message = ""
	if interact_delay > 0.0:
		$Timer.wait_time = interact_delay

func _process(_delta):
	if interactable and Input.is_action_just_pressed("ui_accept"):
		if message.empty():
			if self_interact:
				emit_signal("open")
			else:
				get_parent().interact()
		else:
			DialogueBoxManager.emit_signal('type', message)
		if interact_delay > 0.0:
			interactable = false
			$Timer.start()

func _on_interact_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		icon_holder.visible=show_interact_message
		player_inside=true
		interactable=true

func _on_interact_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		icon_holder.visible=false
		player_inside=false
		interactable=false

func _on_interact_trigger_area_entered(area:Area2D):
	if "playerinteract" in area.name.to_lower():
		icon_holder.visible = show_interact_message
		player_inside=true
		interactable= true

func _on_interact_trigger_area_exited(area:Area2D):
	if "playerinteract" in area.name.to_lower():
		icon_holder.visible=false
		player_inside=false
		interactable=false

func change_text(new_text):
	interact_icon.text = new_text
	self.text= new_text

# Disable the trigger box.
func disable():
	self.monitoring = false
	self.monitorable = false

# Enable the trigger box.
func enable():
	self.monitoring = true
	self.monitorable = true

func _on_Timer_timeout():
	if player_inside:
		interactable = true
