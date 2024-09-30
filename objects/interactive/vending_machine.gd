extends Area2D
class_name VendingMachine

export(int, "NORMAL", "UNUSUAL", "PASSWORD") var vending_type = 2

onready var command_line = $LineWrapper/LineEdit
onready var enter = $MarginContainer2/Label

var _next_scene
var _password = ""
var is_closed = true

func _ready():
	command_line.visible=false
	enter.visible=false

	# TODO: Try to randomize this password using clues from level1.gd
	set_password("t980v") 

func set_password(password):
	_password = password

func set_next_scene(scene):
	_next_scene = scene

func interact():
	if vending_type == 0:
		DialogueBoxManager.emit_signal('type',"A regular vending machine.")
	elif vending_type == 1:
		DialogueBoxManager.emit_signal('type',"An unusual vending machine.\nIt comes with a computer keyboard attached.")
	elif vending_type == 2 and is_closed:
		command_line.grab_focus()
		command_line.visible=true
		print(command_line.visible)
		enter.visible=true
		get_tree().paused=true
	is_closed = true

func _on_LineEdit_text_entered(new_text):
	print(_password)
	if new_text.to_lower() == _password.to_lower():
		print("Change to " + _next_scene)
		get_tree().change_scene(_next_scene)
	command_line.visible=false
	enter.visible=false
	get_tree().paused=false
	print(command_line.visible)
	is_closed = false
