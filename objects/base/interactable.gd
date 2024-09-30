extends Area2D

# A special class of Area2D that allows interaction with certain objects in the game. Make sure you define [code]interact()[/code] in the parent node."
# It does not have its own collision shape. You have to define the collision shape for every object that is made interactible.
class_name Interactable

# The text that would be shown when the player is near an interactable object.
export (String, MULTILINE) var text = "Press 'Space' to Interact"

var interactable = false
onready var holder = $Holder
onready var label = $Holder/Label
onready var sprite = $Holder/Sprite

func _ready():
	holder.visible = false

func _process(_delta):
	if interactable and Input.is_action_just_pressed("ui_accept"):
		print("Interacting with " + get_parent().name)
		get_parent().interact()

func _on_interact_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		holder.visible=true
		interactable=true

func _on_interact_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		holder.visible=false
		interactable=false

func change_text(new_text):
	sprite.visible = false
	label.visible = true
	label.text = new_text
	self.text= new_text
