extends Node2D

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene

func _on_NextLevel_body_entered(body:Node):
	if "player" in body.name.to_lower():
		body.is_active = false
		$TransitionScreen.change_scene(next_scene)

func _on_LocksafeUI_success():
	$WallFG/Locksafe.unlock()
	$WallFG/Locksafe.interact()
	DialogueBoxManager.emit_signal("type", "You open the safe.")

