extends Area2D
class_name transparancable_object

func _on_transparancy_trigger_body_entered(body):
	if "player" in body.name :
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0.7,0.1)

func _on_transparancy_trigger_body_exited(body):
	if "player" in body.name :
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 1,0.1)
