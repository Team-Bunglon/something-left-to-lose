extends Node2D


onready var animator = $animate

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
	"[Smart Raka]\nLet's just go before your brain deactivates again."
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
	"int-smile"
]



var negative_dialogues = [
	"[Strong Raka]\nYou’re such a loser. Did I look like that when I got scared?",
	"[Strong Raka]\nDamn, embarassing.",
	"[Smart Raka]\n...."
]
var negative_expressions = [
	"ath-annoyed",
	"ath-sad",
	"int-sad"
]

var positive_dialogues = [
	"[Strong Raka]\nHow mean..",
	"[Strong Raka]\nBut I like the spirit!\nYou can count on me!",
	"[Smart Raka]\nDon't forget me when you come across.. difficult things.."
]
var positive_expressions = [
	"ath-sad",
	"ath-laugh",
	"int-smile"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(len(dialogues)):
	#	DialogueBoxManager.emit_signal("type", dialogues[i])
	pass

var current_dialogue_index = -1
var negative_dialogue_index = -1
var positive_dialogue_index = -1

var negative_route = false
var positive_route = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if done:
		get_tree().change_scene("res://scenes/Level2.tscn")
		
	elif negative_route:
		if negative_dialogue_index < negative_dialogues.size() - 1:
			negative_dialogue_index += 1
			animator.play(negative_expressions[negative_dialogue_index])
			DialogueBoxManager.emit_signal("type", negative_dialogues[negative_dialogue_index])
		else:
			done = true
			
	elif positive_route:
		if positive_dialogue_index < positive_dialogues.size() - 1:
			positive_dialogue_index += 1
			animator.play(positive_expressions[positive_dialogue_index])
			DialogueBoxManager.emit_signal("type", positive_dialogues[positive_dialogue_index])
		else:
			done = true
	
	elif current_dialogue_index < dialogues.size() - 1:
		current_dialogue_index += 1
		animator.play(expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		
	else:
		$up.visible = true
		$down.visible = true

var done = false
func _on_up_pressed():
	$up.visible = false
	$down.visible = false
	
	Relationship.amount = Relationship.amount +2
	
	print("the amount is ")
	print(Relationship.amount)
	
	positive_route = true
	


func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	Relationship.amount = Relationship.amount -2
	
	print("the amount is ")
	print(Relationship.amount)
	
	negative_route = true
