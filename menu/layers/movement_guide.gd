extends CanvasLayer

onready var returnBtn = $TextureRect/MarginContainer/ReturnButton

func _ready():
	returnBtn.pause_mode = Node.PAUSE_MODE_PROCESS
	
func _on_TextureButton10_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press P to pause the game.")

func _on_TextureButton9_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press Esc to pause the game.")

func _on_TextureButton8_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press SPACEBAR to interact with objects.")

func _on_TextureButton7_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press 3 to change to athletic personality.")

func _on_TextureButton6_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press 2 to change to intelligent personality.")

func _on_TextureButton5_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press 1 to change to default personality.")

func _on_TextureButton4_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press D to move right.")

func _on_TextureButton3_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press S to move downwards.")

func _on_TextureButton2_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press A to move left.")

func _on_TextureButton_mouse_entered():
	DialogueBoxManager.emit_signal("hover_type", "Press W to move upwards.")
	
func _on_TextureButton10_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")

func _on_TextureButton9_mouse_exited():
	DialogueBoxManager.emit_signal("done_typing")

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
	visible = false


