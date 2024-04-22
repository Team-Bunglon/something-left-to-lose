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
