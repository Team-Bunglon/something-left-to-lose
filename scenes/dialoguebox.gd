extends CanvasLayer

onready var label = $TextureRect/MarginContainer/Label
onready var timer_to_type = $typespeed

var speed = 0

signal typing_finish

var typing = false

func _ready():
	DialogueBoxManager.connect("type", self, "set_text")

func set_text(text):
	$TextureRect/MarginContainer2/Label2.visible=false
	get_tree().paused=true
	self.visible=true
	typing = true
	print(text.length())
	label.percent_visible=0
	label.text = text
	speed = 1.0 / text.length()
	timer_to_type.start()

func _on_typespeed_timeout():
	if label.percent_visible>=1:
		typing = false
		$TextureRect/MarginContainer2/Label2.visible=true
		return
	label.percent_visible+=speed
	timer_to_type.start()

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and not typing and speed!=0:
		get_tree().paused=false
		self.visible=false
		speed=0
		emit_signal("typing_finish")
