extends Area2D

# Base class for object that will become transparent whenever the player is standing behind it (or when the object obstructs the player from the camera). 
# It used to be called "transparancable_object" but such word doesn't exist.
class_name Fadeable

func _on_fade_trigger_body_entered(body):
	if "player" in body.name.to_lower():
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "modulate:a", 0.7, 0.1)

func _on_fade_trigger_body_exited(body):
	if "player" in body.name.to_lower():
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "modulate:a", 1, 0.1)
