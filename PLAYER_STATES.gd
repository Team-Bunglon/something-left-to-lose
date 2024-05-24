extends Node

enum STATES {DEFAULT=0, SMART=1, STRONG=2}

signal decrease_stamina(stamina)
signal change_state(state)

var is_holding_key = false
var stamina = 10
var currentState = 0

var items = []

var fullpascode
# dipakai untuk menyimpan full pascode yang nanti didapat setelah gabung 4 kertas

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
		if item.item_name == "key":
			items.erase(item)
			refresh_inventory()
			return
			
func refresh_inventory():
	
	# update visual
	emit_signal("refresh_inventory", items)
	
	# update is_holding_key
	is_holding_key = false
	var mysterious_paper_count = 0
	for item in items:
		if item.item_name == "key":
			is_holding_key = true
		if item.item_name == "mysterious paper":
			mysterious_paper_count += 1
	
	if mysterious_paper_count == 4:
		items = []
		items.append(fullpascode)
		refresh_inventory()

func setState(new_state):
	currentState = new_state
	emit_signal("change_state", new_state)
