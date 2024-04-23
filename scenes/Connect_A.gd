extends Button

func _on_Connect_A_pressed():
	var wire_task = get_node("/root/WireTask")
	var all_disconnected = wire_task.get_node("All_Disconnected")
	var a_connected = wire_task.get_node("A_Connected")
	var wire_sfx = wire_task.get_node("Wire_SFX")
	
	var control = wire_task.get_node("Control")
	var connect_c = control.get_node("Connect_C")
	var connect_a = control.get_node("Connect_A")

	all_disconnected.visible = false
	a_connected.visible = true
	connect_c.visible = true
	connect_a.visible = false
	wire_sfx.play()
