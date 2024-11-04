extends Area2D

var in_area = false
onready var player = null
onready var rock_sfx = $RockBreakSFX
signal break_rock

func _process(delta):
	if in_area and Input.is_action_just_pressed("ui_accept"):
		if player and player.current_state == PLAYER_STATES.STATES.STRONG and Level4Manager.has_sledgehammer:
			emit_signal("break_rock")
			self.queue_free()		
		elif player and player.current_state != PLAYER_STATES.STATES.STRONG and Level4Manager.has_sledgehammer:
			DialogueBoxManager.emit_signal("type", "[Strong Raka]\nSwitch to me so I can break these rocks with ease with the sledgehammer!")
		else:
			DialogueBoxManager.emit_signal("type", "[Raka]\nI need to find something to break these rocks with...")
	
func _on_RockObstacle_body_entered(body):
	if body.name == "player":
		in_area = true
		player = body
		
func _on_RockObstacle_body_exited(body):
	if body.name == "player":
		in_area = false
		player = null

