extends Area2D

func _on_CatHitbox_body_entered(body):
	if body.get_name() == "player":
		get_tree().change_scene("res://scenes/Level2.tscn")
	else:
		pass
