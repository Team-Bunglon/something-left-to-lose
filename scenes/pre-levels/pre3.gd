extends Node2D


onready var animator = $animate

var dialogues = [
	"[Raka]\nThis is.. the canteen.\nHow did it get like this?",
	"[Strong Raka]\nGood question!\nThe one I remembered was definitely not a scary weird chair labyrinth.\nYou did this, stick-in-the-mud guy?",
	"[Smart Raka]\nStick-in-the –!!",
	"[Smart Raka]\nSigh.. It's the hallucination again.",
	"[Raka]\nSo, it's all in my mind?",
	"[Smart Raka]\nYes, but still, you can feel it physically. So, to get out before things get any more dangerous, we need to go west.",
	"[Strong Raka]\nI figure the creepy hallucinations thing is going to chase us again?",
	"[Smart Raka]\nYep.",
	"[Strong Raka]\nMan…"
]


var expressions = [
	"def-shocked",
	"ath-confused",
	"int-angry",
	"int-sigh",
	"def-sad",
	"int-neutral",
	"ath-annoyed",
	"int-neutral",
	"ath-sad"
]



var negative_dialogues = [
	"[Strong Raka]\nOh, I'm sorry that we have been helping you all this time!",
	"[Strong Raka]\nMust have been so hard for you to just cooperate huh??",
	"[Smart Raka]\nEnough.",
	"[Smart Raka]\nHonestly, I am disappointed too. So let's just get this over with."
]
var negative_expressions = [
	"ath-angry",
	"ath-sad",
	"int-angry",
	"int-sad"
]

var positive_dialogues = [
	"[Strong Raka]\nAbsolutely!\nCant wait to inhale some pudding in our fridge once we got home!",
	"[Strong Raka]\nTalking about food,\nI'm famished from all that running.",
	"[Smart Raka]\nWe can probably find food somewhere around here, try to keep an eye out."
]
var positive_expressions = [
	"ath-laugh",
	"ath-annoyed",
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
		get_tree().change_scene("res://scenes/level3/level3CS.tscn")
		
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
	
	Relationship.amount = Relationship.amount -3
	#Relationship.amount.set
	
	print("the amount is ")
	print(Relationship.amount)
	
	negative_route = true
	


func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	Relationship.amount = Relationship.amount +1
	
	print("the amount is ")
	print(Relationship.amount)
	
	positive_route = true
