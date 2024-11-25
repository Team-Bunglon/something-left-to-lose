extends Level0

onready var night_bgm = preload("res://assets/bgm/lv0/bedroom_loud.mp3")

var start = [
	"[Raka]\n(My dad is back. I have to see him...)",
	"[Raka]\nOn my way, dad!",
	"Press WASD or the arrow keys to move.",
	"Press Space to interact with object.",
]

var start_exp = [
	"def-neutral",
	"def-shocked",
	"none",
	"none",
]

var door = [
	"[Raka]\nWait, why did I locked the door?",
	"[Raka]\nI guess I should find the key. Perhaps I put it around the bathroom sink...",
]

var door_exp = [
	"def-shocked",
	"def-neutral",
]

var bathroom_a = [
	"[Raka]\nIt's not here either. Where did I put it?",
	"[???]\nOh, the poor fella right here can't find the key.",
	"[???]\nLook at the mirror, Raka. We'll help you.",
	"[Raka]\nWho's there?",
	"[???]\nJust look at the mirror. Trust me.",
]

var bathroom_b = [
	"[???]\nChange your mind already?",
]

var bathroom_no_1 = [
	"[???]\nLook at the mirror!",
	"[???]\nIt's not that I'm gonna bite you or something.",
]

var bathroom_no_2 = [
	"[???]\nLook.",
	"[???]\nAt.",
	"[???]\nThe.",
	"[???]\nMIRROR!",
]

var bathroom_no_3 = [
	"[???]\nOkay, fine. Do your own thing! I just want to help you.",
]

var bathroom_no_4 = [
	"[???]\n...",
]


var bathroom_yes_1 = [
	"You look at the mirror.",
	"There is somebody that looks just like you. But you look different."
]

var jacket = [
	"[Raka?]\nThere seems to be something rigid under this pile of clothes.",
	"[Raka?]\nWell, better start digging",
]

var jacket_exp = [
	"int-neutral",
	"int-smile",
]

var laptop_1 = [
	"[Raka?]\nStill upset about that one email, huh?",
]

var laptop_1_exp = [
	"int-sad"
]

var laptop_2 = [
	"Dear Raka,\nAfter a heavy consideration, we regret to inform you that you didn't pass the qualification to join the sport faculty.",
	"Something Something I want to die."
]

var key = [
	"[Raka?]\nIf this room were mine, I would organize it better.",
	"[Raka?]\nOh well, time to move on.",
]

var defied = false
var jacket_dialogue = false

func _ready():
	._ready()

	Level4SFX.play_bgm(night_bgm, Level4SFX.bgm_player)

	connect("dialogue_finish", self, "_on_dialogue_finish")
	player.inactive()

func _process(_delta):
	if Input.is_action_pressed("ui_accept") and start_dialogue:
		if current_dialogue_name == "start":
			_advance_dialogue(start, start_exp)
		elif current_dialogue_name == "door":
			_advance_dialogue(door,  door_exp)
		elif current_dialogue_name == "bathroom_a":
			_advance_dialogue(bathroom_a)
		elif current_dialogue_name == "bathroom_b":
			_advance_dialogue(bathroom_b)
		elif current_dialogue_name == "bathroom_no_1":
			_advance_dialogue(bathroom_no_1)
		elif current_dialogue_name == "bathroom_no_2":
			_advance_dialogue(bathroom_no_2)
		elif current_dialogue_name == "bathroom_no_3":
			_advance_dialogue(bathroom_no_3)
		elif current_dialogue_name == "bathroom_no_4":
			_advance_dialogue(bathroom_no_4)
		elif current_dialogue_name == "bathroom_yes_1":
			_advance_dialogue(bathroom_yes_1)
		elif current_dialogue_name == "jacket":
			_advance_dialogue(jacket, jacket_exp)
		elif current_dialogue_name == "laptop_1":
			_advance_dialogue(laptop_1, laptop_1_exp)
		elif current_dialogue_name == "laptop_2":
			_advance_dialogue(laptop_2)
		elif current_dialogue_name == "key":
			_advance_dialogue(key)

func _on_InteractDoor_open():
	if self.name == "Level0A":
		player.inactive()
		$Wall/InteractDoor.disable()
		$Wall/InteractSink.disable()
		$Wall/InteractSink3.enable()
		$LockedSFX.play()
		yield(get_tree().create_timer(1.0), "timeout")
		_start_dialogue("door", door, door_exp)
		$Wall/SingleDoorBottom.enable()
		player.active()

func _on_Key_pick_up():
	if self.name == "Level0A":
		yield(get_tree().create_timer(0.1), "timeout")
		_start_dialogue("key", key)

func _on_TransitionScreen_finish_fade(anim_name:String):
	if anim_name == "start" and self.name == "Level0A":
		_start_dialogue("start", start, start_exp)
		$Wall/InteractTable.enable()
		$Wall/InteractChair.enable()
		player.active()

func _on_ExamineScene3_scene_shown():
	if not defied:
		_start_dialogue("bathroom_a", bathroom_a)
	else:
		_start_dialogue("bathroom_b", bathroom_b)

func _on_ExamineScene3_scene_hidden_half():
	$ExamineScene4.show(true)

func _on_ExamineScene4_scene_hidden():
	$Wall/InteractSink3.disable()
	$Wall/InteractSink2.enable()
	$Wall/InteractClothes.disable()
	$Wall/InteractClothes2.enable()
	$Wall/InteractTable.disable()
	$Wall/InteractTable2.enable()
	$Wall/InteractCupboard.disable()
	$Wall/InteractCupboard2.enable()

func _on_ExamineScene4_scene_shown_half():
	$ExamineScene3.force_hide()

func _on_dialogue_finish(dialogue:String):
	if dialogue == "bathroom_a":
		$ChoiceButtons1.show()
	elif dialogue == "bathroom_b":
		$ChoiceButtons4.show()
	elif dialogue == "bathroom_no_1":
		$ChoiceButtons2.show()
	elif dialogue == "bathroom_no_2":
		$ChoiceButtons3.show()
	elif dialogue == "bathroom_no_3":
		defied = true
		$ExamineScene3.hide()
	elif dialogue == "bathroom_no_4":
		$ExamineScene3.hide()
	elif dialogue == "bathroom_yes_1":
		player.switch_immediately(2)
		$ExamineScene3.hide(true)
	elif dialogue == "jacket":
		$Wall/InteractClothes2.disable()
		$Wall/InteractClothes3.enable()
		$Wall/InteractClothes3.emit_signal("open")
	elif dialogue == "laptop_1":
		$ChoiceButtonsLaptop.show()
	elif dialogue == "laptop_2":
		$Wall/InteractTable2.enable()
		player.active()

func _on_up_pressed():
	$ChoiceButtons1.hide()
	$ChoiceButtons2.hide()
	$ChoiceButtons3.hide()
	$ChoiceButtons4.hide()
	_start_dialogue("bathroom_yes_1", bathroom_yes_1)

func _on_down1_pressed():
	$ChoiceButtons1.hide()
	_start_dialogue("bathroom_no_1", bathroom_no_1)

func _on_down2_pressed():
	$ChoiceButtons2.hide()
	_start_dialogue("bathroom_no_2", bathroom_no_2)

func _on_down3_pressed():
	Relationship.amount = Relationship.amount - 1
	$ChoiceButtons3.hide()
	_start_dialogue("bathroom_no_3", bathroom_no_3)

func _on_down4_pressed():
	$ChoiceButtons4.hide()
	_start_dialogue("bathroom_no_4", bathroom_no_4)

func _on_InteractTable2_open():
	player.inactive()
	$Wall/InteractTable2.disable()
	_start_dialogue("laptop_1", laptop_1, laptop_1_exp)

func _on_InteractClothes2_open():
	if not jacket_dialogue:
		jacket_dialogue = true
		_start_dialogue("jacket", jacket, jacket_exp)

func _on_up_laptop_pressed():
	$ChoiceButtonsLaptop.hide()
	_start_dialogue("laptop_2", laptop_2)

func _on_down_laptop_pressed():
	$ChoiceButtonsLaptop.hide()
	$Wall/InteractTable2.enable()
	player.active()
