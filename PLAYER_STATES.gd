extends Node

enum STATES {DEFAULT=0, SMART=1, STRONG=2}

signal decrease_stamina(stamina)

var is_holding_key = false
var stamina = 10

func decrease_stamina(stamina):
	emit_signal("decrease_stamina", stamina)
	self.stamina = stamina

func hold_key():
	is_holding_key = true

func drop_key():
	is_holding_key = false
