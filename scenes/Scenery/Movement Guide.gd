extends CanvasLayer

onready var spacebar = $TextureRect/TextureButton8

onready var w_btn =$TextureRect/TextureButton
onready var a_btn =$TextureRect/TextureButton2
onready var s_btn =$TextureRect/TextureButton3
onready var d_btn =$TextureRect/TextureButton4
onready var btn_1 =$TextureRect/TextureButton5
onready var btn_2 =$TextureRect/TextureButton6
onready var btn_3 =$TextureRect/TextureButton7
onready var returnBtn = $TextureRect/MarginContainer/ReturnButton

var back_to_main = "res://scenes/Scenery/PreLevel1.tscn"

func _ready():
	returnBtn.pause_mode = Node.PAUSE_MODE_PROCESS


func _on_TextureButton8_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use SPACEBAR to interact with objects")
	spacebar.is_hovered()
	


func _on_TextureButton7_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use 3 to change to athletic personality")
	spacebar.is_hovered()


func _on_TextureButton6_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use 2 to change to intelligent personality")
	spacebar.is_hovered()


func _on_TextureButton5_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use 1 to change to default personality")
	spacebar.is_hovered()


func _on_TextureButton4_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use D to move right")
	spacebar.is_hovered()


func _on_TextureButton3_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use S to move downwards")
	spacebar.is_hovered()


func _on_TextureButton2_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use A to move left")
	spacebar.is_hovered()


func _on_TextureButton_mouse_entered():
	DialogueBoxManager.emit_signal("hover_dia", "use W to move upwards")
	spacebar.is_hovered()


func _on_TextureButton8_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton7_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton6_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton5_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton4_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton3_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton2_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_TextureButton_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")


func _on_ReturnButton_pressed():
	get_tree().change_scene(back_to_main)
