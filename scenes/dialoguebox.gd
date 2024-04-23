extends CanvasLayer

onready var label = $TextureRect/MarginContainer/Label
onready var timer_to_type = $typespeed
onready var yes_no_box = $yes_no_dialogbox

var speed = 0

var typing = false
var is_menu = false

func _ready():
	DialogueBoxManager.connect("type", self, "set_text")
	DialogueBoxManager.connect("pick_up",self,"open_menu")
	DialogueBoxManager.connect("done_typing",self,"close_dialogue_box")
	visible = false

func open_menu(item):
	print(item)
	set_text("Do you want to pick "+str(item.get_name())+" up?")
	is_menu = true
	yes_no_box.item_on_deciding = item
	yes_no_box.popup()

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
	if Input.is_action_pressed("ui_accept") and not typing and not is_menu and speed!=0:
		close_dialogue_box()

func close_dialogue_box():
	print("close dialoggue box")
	get_tree().paused=false
	self.visible=false
	is_menu = false
	speed=0
