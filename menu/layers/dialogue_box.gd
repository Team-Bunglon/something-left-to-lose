extends CanvasLayer

onready var label = $TextureRect/MarginContainer/Label
onready var timer_to_type = $TypeSpeed
onready var yes_no_box = $YesNoBox
onready var mainmenu_bg = $lvl1_bg

var timing_start = 0.2
var speed = 0
var typing = false
var is_menu = false
var show_label2 = true
var is_option = false

func _ready():
	DialogueBoxManager.connect("type", self, "set_text")
	DialogueBoxManager.connect("lvl3", self, "set_text_lvl3")
	DialogueBoxManager.connect("pick_up",self,"open_menu")
	DialogueBoxManager.connect("done_typing",self,"close_dialogue_box")
	DialogueBoxManager.connect("hover_dia" ,self, "on_hover_text")

	visible = false

func open_menu(item):
	if PLAYER_STATES.items.size() > 3:
		print("inventory full")
		DialogueBoxManager.emit_signal("type", "Your inventory is full")
		return
		
	print(item)
	set_text("Do you want to pick "+str(item.get_name())+" up?")
	is_menu = true
	yes_no_box.item_on_deciding = item
	yes_no_box.popup()

func set_text(text):
	mainmenu_bg.visible = false
	show_label2 = true
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

func set_text_lvl3(text):
	mainmenu_bg.visible = false
	show_label2 = false
	timing_start = 0.2
	$TextureRect/MarginContainer2/Label2.visible=false
	self.visible=true
	typing = true
	print(text.length())
	label.percent_visible=0
	label.text = text
	speed = 1.2 / text.length()
	timer_to_type.start()

# movement guide
func on_hover_text(text):
	mainmenu_bg.visible = false
	show_label2 = false
	timing_start = 0.2
	$TextureRect/MarginContainer2/Label2.visible=false
	self.visible=true
	typing = true
	print(text.length())
	label.percent_visible=0
	label.text = text
	speed = 1.2 / text.length()
	timer_to_type.start()

# This is where the typing animation is handled.
func _on_typespeed_timeout():
	if label.percent_visible>=1 and not is_menu:
		typing = false
		if show_label2 == true:
			$TextureRect/MarginContainer2/Label2.visible=true
		else:
			$TextureRect/MarginContainer2/Label2.visible=false
		return
	elif label.percent_visible >= 1 and not is_menu:
		typing = false
		return
	elif label.percent_visible >= 1:
		typing=false
	elif label.percent_visible < 1:
		label.percent_visible += speed
		timer_to_type.start()

func _process(delta):
	DialogueBoxManager.is_typing = typing
	
	if Input.is_action_just_pressed("ui_accept") and not typing and not is_menu and speed != 0:
		close_dialogue_box()
	elif Input.is_action_just_pressed("ui_accept") and typing and speed != 0 and timing_start < 0:
		label.percent_visible=1
		typing = false
	if typing and timing_start > 0:
		$AudioStreamPlayer.play()
		timing_start -= delta
	elif not typing:
		$AudioStreamPlayer.stop()

func close_dialogue_box():
	$AudioStreamPlayer.stop()
	get_tree().paused=false
	self.visible=false
	is_menu = false
	speed=0
