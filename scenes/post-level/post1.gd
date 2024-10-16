extends Node2D


onready var animator = $animate

var dialogues = [
		"[Raka]\nMy laptop!",
		"[Raka]\nWhew! Thank goodness.",
		"[Smart Raka]\nYou're welcome."

]

var expressions = [
	"def-shocked",
	"def-happy",
	"int-smile"
]



var negative_dialogues = [
	"[Smart Raka]\nWhat?! I was just trying to-",
	"[Smart Raka]\nSigh.. whatever.",
	"[Strong Raka]\n...."
]
var negative_expressions = [
	"int-angry",
	"int-sad",
	"ath-sad"
]

var positive_dialogues = [
	"[Smart Raka]\n... Do you feel better-",
	"[Smart Raka]\nI mean- you don't feel so useless now right?",
	"[Raka]\nHuh? Yes, I guess..\n(But its mostly him though..)",
	"[Strong Raka]\nAwww how sweet~",
	"[Smart Raka]\nShut it, donkey."
]
var positive_expressions = [
	"int-smile",
	"int-annoyed",
	"def-smile",
	"ath-laugh",
	"int-annoyed"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(len(dialogues)):
	#	DialogueBoxManager.emit_signal("type", dialogues[i])
	current_dialogue_index = -1
	pass

var current_dialogue_index = -1
var negative_dialogue_index = -1
var positive_dialogue_index = -1

var negative_route = false
var positive_route = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if done:
		get_tree().change_scene("res://scenes/pre-levels/transition-2.tscn")
		
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
	
	print("the amount is ")
	print(Relationship.amount)
	
	negative_route = true
	print(negative_route)
	


func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	Relationship.amount = Relationship.amount +2
	
	print("the amount is ")
	print(Relationship.amount)
	
	positive_route = true
