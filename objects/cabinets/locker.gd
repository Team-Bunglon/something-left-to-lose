extends StaticBody2D

export var contains_paper = false
onready var opened = $Opened
onready var closed = $Closed

func interact():
	# Ignore object if it's already been opened
	if not closed.visible:
		return
		
	# Nothing here
	if not contains_paper:
		closed.visible = false
		DialogueBoxManager.emit_signal("type", "You found nothing...")
		return
		
	# Inventory full
	if PLAYER_STATES.items.size() > 4:
		DialogueBoxManager.emit_signal("type", """There's something in here.
		But your inventory is full""")
		return
	
	# collect paper
	closed.visible = false
	PLAYER_STATES.add_item($"MysteriousPaper")
	DialogueBoxManager.emit_signal("type", "You found a mysterious piece of torn paper.")
	PLAYER_STATES.check_paper_count()
	
func glow():
	if contains_paper:
		if closed.modulate.r!=1 and closed.modulate.b!=1:
			closed.modulate.r=1
			closed.modulate.b=1
			closed.modulate.g=1
			return
		closed.modulate = closed.modulate.darkened(0.4)
