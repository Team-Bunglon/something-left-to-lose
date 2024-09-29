#
# Ini berfungsi sebagai sub instance dari suatu instance yang interactable
#

extends Node

var interactable = false
onready var label_holder = $label_holder
onready var label = $label_holder/Label
var text = "Press 'Space' to Interact"

func _ready():
	label_holder.visible = false

func _process(delta):
	if interactable and Input.is_action_just_pressed("ui_accept"):
		get_parent().interact()

func _on_interact_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		print("where is my label")
		label_holder.visible=true
		interactable=true

func _on_interact_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		label_holder.visible=false
		interactable=false

func change_text(text):
	label.text = text
	self.text= text
