extends Node2D

export (String, FILE, "*.tscn") var next_scene

onready var animator = $Animate
onready var u = $Up
onready var d = $Down

var dialogues = [
		"[Raka]\nMy laptop!",
		"[Raka]\nWhew! Thank goodness.",
		"[Smart Raka]\nYou're welcome.",
]

var expressions = [
	"def-shocked",
	"def-happy",
	"int-smile",
]

var negative_dialogues = [
	"[Smart Raka]\nWhat?! I was just trying to-",
	"[Smart Raka]\nSigh... whatever.",
	"[Strong Raka]\n...",
]
var negative_expressions = [
	"int-angry",
	"int-sad",
	"ath-sad",
]

var positive_dialogues = [
	"[Smart Raka]\n... Do you feel better-",
	"[Smart Raka]\nI mean- you don't feel so useless now, right?",
	"[Raka]\nHuh? Yeah, I guess...\n(But it's mostly him though...)",
	"[Strong Raka]\nAwww how sweet.",
	"[Smart Raka]\nShut it, donkey.",
]

var positive_expressions = [
	"int-smile",
	"int-annoyed",
	"def-smile",
	"ath-laugh",
	"int-annoyed",
]

enum {START, POSITIVE, NEGATIVE, CHOICE}
var route = START
var done = false
var d_index = 0

func _process(delta):
	if done:
		get_tree().change_scene(next_scene)
	elif route == START:
		if _run_dialogue(expressions, dialogues):
			route = CHOICE
	elif route == POSITIVE:
		if _run_dialogue(positive_expressions, positive_dialogues):
			done = true
	elif route == NEGATIVE:
		if _run_dialogue(negative_expressions, negative_dialogues):
			done = true
	else:
		u.visible = true
		d.visible = true

# Run list of dialogues. Return true if finished.
func _run_dialogue(expressions, dialogues):
	if d_index < dialogues.size():
		animator.play(expressions[d_index])
		DialogueBoxManager.emit_signal("type", dialogues[d_index])
		d_index += 1
		return false
	else:
		d_index = 0
		return true

func _on_up_pressed():
	u.visible = false
	d.visible = false
	
	Relationship.amount -= 3
	route = NEGATIVE
	
	print("DEBUG - Relationship:")
	print(Relationship.amount)
	
func _on_down_pressed():
	u.visible = false
	d.visible = false
	
	Relationship.amount += 2
	route = POSITIVE
	
	print("DEBUG - Relationship:")
	print(Relationship.amount)
