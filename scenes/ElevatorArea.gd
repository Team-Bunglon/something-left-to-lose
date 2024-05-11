extends Area2D

func _on_ElevatorArea_body_entered(body):
	if body.get_name() == "player":
		var transition_screen = get_parent().get_parent().get_node("TransitionScreen1")
		transition_screen.change_scene("res://scenes/WireTask.tscn")
	else:
		pass
