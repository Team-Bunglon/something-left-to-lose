extends Area2D

# An invisible area that teleports player into a coordinate in its global position.
class_name Teleporter

enum Apply {BOTH, X_ONLY, Y_ONLY}
var teleport_target

# The location of where the player should be placed when he enters the zone.
export var teleport_location = Vector2(0,0)

# The axis the teleporter should apply
export (Apply) var apply_axis = Apply.BOTH

func _on_Teleporter_body_entered(body:Node):
	if "player" in body.name.to_lower():
		teleport_target = teleport_location

		if apply_axis == Apply.X_ONLY:
			teleport_target = Vector2(teleport_location.x, body.global_position.y)
		elif apply_axis == Apply.Y_ONLY:
			teleport_target = Vector2(body.global_position.x, teleport_location.y)

		body.global_position = teleport_target
