extends StaticBody2D

export var contains_paper = false

func interact():
	
	# sudah pernah dibuka
	if !$closed.visible:
		return
		
	# nothing here
	if !contains_paper:
		$closed.visible = false
		DialogueBoxManager.emit_signal("type", "You found nothing..")
		return
		
	# inventory full
	if PLAYER_STATES.items.size() > 3:
		DialogueBoxManager.emit_signal("type", """There's something in here.
		But your inventory is full""")
		return
	
	# collect paper
	$closed.visible = false
	PLAYER_STATES.add_item($"mysterious paper")
	DialogueBoxManager.emit_signal("type", "You found a mysterious piece of torn paper.")
	
	
