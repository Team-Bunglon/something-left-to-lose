extends Button

func _on_Connect_B_pressed():
	var wire_task = get_node("/root/WireTask")
	var ac_connected = wire_task.get_node("AC_Connected")
	var abc_connected = wire_task.get_node("ABC_Connected")
	var wire_sfx = wire_task.get_node("Wire_SFX")
	
	var control = wire_task.get_node("Control")
	var connect_b = control.get_node("Connect_B")

	ac_connected.visible = false
	abc_connected.visible = true
	connect_b.visible = false
	wire_sfx.play()

	var scene_change_timer = Timer.new()
	scene_change_timer.wait_time = 2.0
	scene_change_timer.one_shot = true
	scene_change_timer.connect("timeout", self, "_on_scene_change_timeout")
	add_child(scene_change_timer)
	scene_change_timer.start()

func _on_scene_change_timeout():
	get_tree().change_scene("res://scenes/Level2LiftOpening.tscn")
