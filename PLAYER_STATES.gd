extends Node

enum STATES {DEFAULT=0, SMART=1, STRONG=2}

signal decrease_stamina(stamina)
signal change_state(state)


var is_holding_key = false
var stamina = 10
var currentState = 0

var items = []

var fullpascode
var blurpasscode
# dipakai untuk menyimpan full pascode yang nanti didapat setelah gabung 4 kertas

onready var keySFX = get_node("/root/baselevel/KeySFX")
onready var paperSFX = get_node("/root/baselevel/PaperSFX")


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
	for item in items:
		if item.item_name == "key":
			keySFX.play()
			is_holding_key = true
		if item.item_name == "mysterious paper":
			paperSFX.play()
						
func check_paper_count():
	var mysterious_paper_count = 0
	for item in items:
		if item.item_name == "mysterious paper":
			mysterious_paper_count += 1
	if mysterious_paper_count == 4 and PLAYER_STATES.currentState != 1: 
		DialogueBoxManager.emit_signal("type", """[Raka]\nI think I've got them all.... I pieced them together but I can't make out what these words are saying. 
		I'm not smart enough to understand...\n(Press 2 to change to Intelligent personality)
		""")
		items = []
		items.append(blurpasscode)
		refresh_inventory()
					
	elif mysterious_paper_count == 4 or blurpasscode in items and PLAYER_STATES.currentState == 1:
		DialogueBoxManager.emit_signal("type", "[Raka 2]\nThere. I deciphered the papers for you. Hehe, you're welcome.")
		items = []
		items.append(fullpascode)
		refresh_inventory()	
			
			
			

func setState(new_state):
	currentState = new_state
	emit_signal("change_state", new_state)
