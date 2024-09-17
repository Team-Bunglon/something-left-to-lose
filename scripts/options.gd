extends Control


signal closedMenu

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	self.visible = false
	get_tree().paused = false
	emit_signal("closedMenu")


func _on_MuteCheckBox_toggled(button_pressed):
	AudioServer.set_bus_mute(0, button_pressed)


func _on_FullScreenCheckBox_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
