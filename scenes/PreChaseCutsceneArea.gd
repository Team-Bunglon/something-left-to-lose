extends Area2D

func _on_PreChaseCutsceneArea_body_entered(body):
	if body.get_name() == "player":
		var transition_screen = get_parent().get_parent().get_node("TransitionScreen1")
		transition_screen.change_scene("res://scenes/Level2PreChaseCS.tscn")
	else:
		pass
