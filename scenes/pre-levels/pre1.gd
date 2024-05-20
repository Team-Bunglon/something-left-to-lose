extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animator = $animate

var dialogues = [
	"[Expressive Guy]\nBASTARDS! How dare they lock us in here?\nI SWEAR i'm going to-",
	"[Sarcastic Guy]\nCool down you donkey. It's just some prankster.\nBut..what a pain, they ruined my plan.",
	"[Expressive Guy]\nWhat plan again?",
	"[Sarcastic Guy]\nIts-",
	"[Raka]\nHuh? what? who’s talking..?",
	"[Sarcastic Guy]\nSigh.. another dork is talking",
	"[Raka]\nWho are you? What did you do?!",
	"[Expressive Guy]\nOh,yeah,hi,\nSo we are you and you are us!",
	"[Raka]\nWhat? i dont understand",
	"[Raka 2]\nOf course you dont..\nUgh, with your level of intelligence, we will never get out of here",
	"[Raka 3]\nYou are too dramatic, with my power we can just break this door",
	"[Raka]\n(Power..?)",
	"[Raka 2]\nDont even think about it. Property damage? seriously?\n...Listen, i know where are the items we might need are located\nIncluding the keys..",
	"[Raka 2]\nWell, i put them away myself.\nThough, i can't remember exactly where i hid them.\nYou know how it is with memories",
	"[Raka]\nYou hid them? why?!",
	"[Raka 3]\nWHOA haha how fun!",
	"[Raka 2]\nYeah.. fun\nJust, trust me. Let me do this, or we can never get out of here\n(Use key '2' to access his power)"
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
	DialogueBoxManager.emit_signal("type", "[Raka 2]\nWell, you dont have a choice")
	
	Relationship.amount =-1
	
	print("the amount is ")
	print(Relationship.amount)
	
	done = true

func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	animator.play("int-smile")
	DialogueBoxManager.emit_signal("type", "[Raka 2]\nAlright")
	
	Relationship.amount =+1
	
	print("the amount is ")
	print(Relationship.amount)
	
	done = true
