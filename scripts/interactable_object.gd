#
# Ini berfungsi sebagai sub instance dari suatu instance yang interactable
#

extends Node

# The message that the object will show when interacting. If not set, the object will try to trigger the [code]interact()[/code] function of the parent.
export(String, MULTILINE) var message

# Show the text or prompt when the player is near an interactible object.
export var show_interact_message = true

var interactable = false
onready var label_holder = $label_holder
onready var label = $label_holder/Label
var text = "Press 'Space' to Interact"

func _ready():
	label_holder.visible = false

func _process(_delta):
	if interactable and Input.is_action_just_pressed("ui_accept"):
		if message.empty():
			get_parent().interact()
		else:
			DialogueBoxManager.emit_signal('type', message)

func _on_interact_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		label_holder.visible=show_interact_message
		interactable=true

func _on_interact_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		label_holder.visible=false
		interactable=false

func change_text(new_text):
	label.text = new_text
	self.text= new_text
