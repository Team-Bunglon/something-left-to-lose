extends CanvasLayer

onready var label = $TextureRect/MarginContainer/Label
onready var timer_to_type = $typespeed
onready var yes_no_box = $yes_no_dialogbox

var speed = 0

var timing_start

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
	timing_start = 0.2
	$TextureRect/MarginContainer2/Label2.visible=false
	get_tree().paused=true
	self.visible=true
	typing = true
	print(text.length())
	label.percent_visible=0
	label.text = text
	speed = 1.2 / text.length()
	timer_to_type.start()

func _on_typespeed_timeout():
	if label.percent_visible>=1 and not is_menu: 
		typing = false
		$TextureRect/MarginContainer2/Label2.visible=true
		return
	elif label.percent_visible>=1 :
		typing=false
	elif label.percent_visible<1:
		label.percent_visible+=speed
		timer_to_type.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and not typing and not is_menu and speed!=0:
		close_dialogue_box()
	elif Input.is_action_just_pressed("ui_accept") and typing and speed!=0 and timing_start<0:
		label.percent_visible=1
		typing = false
	if typing and timing_start>0:
		timing_start-=delta

func close_dialogue_box():
	get_tree().paused=false
	self.visible=false
	is_menu = false
	speed=0
