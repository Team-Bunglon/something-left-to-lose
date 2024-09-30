extends Node2D

export (String, FILE, "*.tscn") var next_scene

onready var animator = $Animate
onready var u = $Up
onready var d = $Down

var dialogues = [
	"[Strong Raka]\nIt’s crazy dark in here, scary..",
	"[Raka]\nWhat?? Where are we again?",
	"[Smart Raka]\nIt’s bad. Now that you've become aware of us, your psychological consciousness is unstable. You've lost control over your body... Not only that, the halluci-",
	"[Strong Raka]\nPHYsiological soncio what..\nPhysical activity? Should we run?",
	"[Smart Raka]\nI'm dead. I'm stuck in a building with two blockheads and no way out. It's over.",
	"[Strong Raka]\nCheck out drama king over here.",
	"[Raka]\nSorry, can you explain it again?",
	"[Smart Raka]\nIt's like you're sleepwalking.\nFor a second, you moved unconsciously and we landed here. Plus... we should be wary of the hallucinations.",
	"[Raka]\nHallucinations?",
	"[Smart Raka]\nYes, the negative thoughts that have been haunting you finally manifested.\nThey can hurt you - us physically now. We need to run from them, or else…",
	"[Strong Raka]\nRun? Nice, I can run fast! Use my power!\n(Use key '3' to access his power)",
	"[Smart Raka]\nFinally, you used that one brain cell you have been blessed with.",
	"[Strong Raka]\nOf course! I actually-",
	"[Strong Raka]\nWait.. WAS THAT AN INSULT?!",
	"[Smart Raka]\nLet's just go before your brain deactivates again.",
]


var expressions = [
	"ath-sad",
	"def-shocked",
	"int-sad",
	"ath-confused",
	"int-sigh",
	"ath-laugh",
	"def-neutral",
	"int-neutral",
	"def-sad",
	"int-neutral",
	"ath-laugh",
	"int-smile",
	"ath-happy",
	"ath-angry",
	"int-smile",
]

var positive_dialogues = [
	"[Strong Raka]\nHow mean..",
	"[Strong Raka]\nBut I like the spirit!\nYou can count on me!",
	"[Smart Raka]\nDon't forget me when you come across.. difficult things..",
]

var positive_expressions = [
	"ath-sad",
	"ath-laugh",
	"int-smile",
]

var negative_dialogues = [
	"[Strong Raka]\nYou’re such a loser. Did I look like that when I got scared?",
	"[Strong Raka]\nDamn, embarassing.",
	"[Smart Raka]\n....",
]

var negative_expressions = [
	"ath-annoyed",
	"ath-sad",
	"int-sad",
]

enum {START, POSITIVE, NEGATIVE, CHOICE}
var route = START
var done = false
var d_index = 0 # (Current) dialogue index

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
	
	Relationship.amount += 2
	route = POSITIVE
	
	print("DEBUG - Relationship:")
	print(Relationship.amount)

func _on_down_pressed():
	u.visible = false
	d.visible = false
	
	Relationship.amount -= 3
	route = NEGATIVE
	
	print("DEBUG - Relationship:")
	print(Relationship.amount)
