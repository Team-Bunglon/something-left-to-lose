extends Area2D

func _on_ElevatorArea_body_entered(body):
	if body.get_name().to_lower() == "player":
		var player_collision_shape = body.get_node("CollisionShape2D")
		var transition_screen = get_parent().get_parent().get_node("TransitionScreen1")
		
		player_collision_shape.disabled = true
		transition_screen.change_scene("res://scenes/WireTask.tscn")
	else:
		pass
