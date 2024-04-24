extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_Area2D_body_entered(body):
	var player_stamina = PLAYER_STATES.stamina
	print(body.name)
	if body.name == "player":
		if player_stamina < 10 :
			PLAYER_STATES.decrease_stamina(player_stamina+1)
		yield(get_tree().create_timer(0.1), "timeout")
		queue_free()
		
