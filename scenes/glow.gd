extends Node2D

func _ready():
	PLAYER_STATES.connect("change_state",self,"glow_parent")

func glow_parent(state):
	if state==PLAYER_STATES.STATES.SMART:
		self.get_parent().glow()
	else:
		self.get_parent().glow()
