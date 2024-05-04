extends Node

enum STATES {DEFAULT=0, SMART=1, STRONG=2}

signal decrease_stamina(stamina)

var is_holding_key = false
var stamina = 10
var currentState = 0

var items = []

signal refresh_inventory

func _ready():
	DialogueBoxManager.connect("add_item",self,"add_item")

func decrease_stamina(stamina):
	emit_signal("decrease_stamina", stamina)
	self.stamina = stamina
	
func add_item(item):
	items.append(item)
	refresh_inventory()

func drop_key():
	for item in items:
		if item is Key:
			items.erase(item)
			refresh_inventory()
			return
			
func refresh_inventory():
	
	# update visual
	emit_signal("refresh_inventory", items)
	
	# update is_holding_key
	for item in items:
		if item is Key:
			is_holding_key = true
			return
	is_holding_key = false

func setState(new_state):
	currentState = new_state
