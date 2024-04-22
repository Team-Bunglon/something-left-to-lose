extends Button

func _on_Connect_C_pressed():
	var wire_task = get_node("/root/WireTask")
	var a_connected = wire_task.get_node("A_Connected")
	var ac_connected = wire_task.get_node("AC_Connected")
	var wire_sfx = wire_task.get_node("Wire_SFX")
	
	var control = wire_task.get_node("Control")
	var connect_c = control.get_node("Connect_C")
	var connect_b = control.get_node("Connect_B")

	a_connected.visible = false
	ac_connected.visible = true
	connect_c.visible = false
	connect_b.visible = true
	wire_sfx.play()
