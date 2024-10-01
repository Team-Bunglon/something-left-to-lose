extends Area2D

func _on_CatHitbox_body_entered(body):
	var player_collision_shape = body.get_node("CollisionShape2D")
	if body.get_name().to_lower() == "player" && player_collision_shape.disabled == false:
		get_tree().change_scene("res://scenes/Deathscene.tscn")
	else:
		pass
