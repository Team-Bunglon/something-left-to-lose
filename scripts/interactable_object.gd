extends Node

var interactable = false
onready var label_holder = $label_holder
onready var label = $label_holder/Label
onready var sprite = $label_holder/Sprite
var text = "Press 'Space' to Interact"

func _ready():
	label_holder.visible = false

func _process(_delta):
	if interactable and Input.is_action_just_pressed("ui_accept"):
		get_parent().interact()

func _on_interact_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		label_holder.visible=true
		interactable=true

func _on_interact_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		label_holder.visible=false
		interactable=false

func change_text(new_text):
	sprite.visible = false
	label.visible = true
	label.text = new_text
	self.text= new_text
