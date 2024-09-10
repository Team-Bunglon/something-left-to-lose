extends StaticBody2D

export var contains_paper = false
onready var opened_sprite = $opened
onready var closed_sprite = $closed

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
	PLAYER_STATES.check_paper_count()
	
func glow():
	if contains_paper:
		if closed_sprite.modulate.r!=1 and closed_sprite.modulate.b!=1:
			closed_sprite.modulate.r=1
			closed_sprite.modulate.b=1
			closed_sprite.modulate.g=1
			return
		closed_sprite.modulate = closed_sprite.modulate.darkened(0.4)
