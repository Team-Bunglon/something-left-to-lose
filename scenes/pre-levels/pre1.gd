extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animator = $animate

var dialogues = [
	"[Expressive Guy]\nBASTARDS! How dare they lock us in here?\nI SWEAR i'm going to-",
	"[Sarcastic Guy]\nCool down you donkey. It's just some prankster.\nBut..what a pain, they ruined my plan.",
	"[Expressive Guy]\nWhat plan again?",
	"[Sarcastic Guy]\nIt's-",
	"[Raka]\nHuh? What? who’s talking..?",
	"[Sarcastic Guy]\nSigh.. another dork chimed in.",
	"[Raka]\nWho are you? What did you do?!",
	"[Expressive Guy]\nOh, yeah, hi, So we are you and you are us! You can call me... Strong Raka.",
	"[Raka]\nWhat? I dont understand...",
	"[Smart Raka]\nOf course you dont..\nUgh, with your level of intelligence, we will never get out of here.",
	"[Strong Raka]\nYou're too dramatic, with my power we can just break this door!",
	"[Raka]\n(Power..?)",
	"[Smart Raka]\nDont even think about it. Property damage? seriously?\n...Listen, I know where the items we might need are located.\nIncluding the keys..",
	"[Smart Raka]\nWell, I put them away myself. Though, i can't remember exactly where I hid them. You know how it is with memories.",
	"[Raka]\nYou hid them? why?!",
	"[Strong Raka]\nWHOA haha how fun!!",
	"[Smart Raka]\nYeah.. fun. Just, trust me. Once we find everything we need, let me handle the rest, or else we can never get out of here.\n(Use key '2' to access his power)"
]

var expressions = [
	"ath-angry",
	"int-annoyed",
	"ath-confused",
	"int-neutral",
	"def-shocked",
	"int-sigh",
	"def-shocked",
	"ath-laugh",
	"def-sad",
	"int-annoyed",
	"ath-neutral",
	"def-sad",
	"int-neutral",
	"int-smile",
	"def-shocked",
	"ath-laugh",
	"int-smile"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(len(dialogues)):
	#	DialogueBoxManager.emit_signal("type", dialogues[i])
	pass

var current_dialogue_index = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_dialogue_index < dialogues.size() - 1:
		current_dialogue_index += 1
		animator.play(expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
	
	elif done:
		get_tree().change_scene("res://scenes/level1/level1.tscn")

	else:
		$up.visible = true
		$down.visible = true

var done = false
func _on_up_pressed():
	$up.visible = false
	$down.visible = false
	
	animator.play("int-annoyed")
	DialogueBoxManager.emit_signal("type", "[Smart Raka]\nWell, you dont have a choice.")
	
	Relationship.amount = Relationship.amount -1
	
	print("the amount is ")
	print(Relationship.amount)
	
	done = true

func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	animator.play("int-smile")
	DialogueBoxManager.emit_signal("type", "[Smart Raka]\nAlright.")
	
	Relationship.amount = Relationship.amount +1
	
	print("the amount is ")
	print(Relationship.amount)
	
	done = true
