extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animator = $animate

var dialogues = [
	"[Raka]\nAre we... free? Is it over?",
	"[Strong Raka]\nWell, judging from our surroundings... looks like we're still in limbo.",
	"[Smart Raka]\nI'm afraid not. We've only managed to escape the first layer of your subconscious.",
	"[Raka]\n...the first? How many layers are there?",
	"[Smart Raka]\nJudging from all the trauma you've built up these past few years, I'd say we still have a long way to go.",
	"[Raka]\nAh... I'm making it harder for you guys... sorry...",
	"[Strong Raka]\nDon't worry! I'm not even remotely tired yet!",
	"[Smart Raka]\nWhen you've got muscles for brains, I'm not surprised.",
	"[Strong Raka]\nCan you give me a break??",
	"[Smart Raka]\nAnyway, relax. The plan is still in motion.",
	"[Smart Raka]\nWhat we need to do next is to go back home. And to do that, we need to go to the train station.",
	"[Smart Raka]\nThere should be a bus stop down the embankment. Let's head there now."	
]

var expressions = [
	"def-neutral",
	"ath-confused",
	"int-sigh",
	"def-shocked",
	"int-neutral",
	"def-sad",
	"ath-happy",
	"int-smile",
	"ath-angry",
	"int-smile",
	"int-neutral",
	"int-smile"
]


# Called when the node enters the scene tree for the first time.
func _ready():
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
