extends Button

onready var TransitionScreen1 = get_parent().get_parent()

func _on_RestartButton_pressed():
	self.visible = false
	TransitionScreen1.change_scene("res://scenes/Level2Lanjutan.tscn")
