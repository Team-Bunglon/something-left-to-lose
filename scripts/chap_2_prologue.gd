extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animator = $animate
onready var buttons = get_tree().get_nodes_in_group("button")
export (String) var next_scene 
var done = false

var dialogues = [
	"[Raka]\nAre we... free? Is it over?",
	"[Strong Raka]\nWell, looking at the surroundings... looks like we're still in limbo.",
	"[Smart Raka]\nI'm afraid not. We've only managed to escape the first layer of your subconscious.",
	"[Raka]\n...the first? How many layers are there?",
	"[Smart Raka]\nJudging from all the trauma you've built up these past few years, I'd say we still have a long way to go.",
	"[Raka]\nAh... I'm making it harder for you guys... sorry...",
	"[Strong Raka]\nDon't worry! I'm not even remotely tired yet!",
	"[Smart Raka]\nWhen you've got muscles for brains, I'm not surprised.",
	"[Strong Raka]\nCan you give me a break??",
	"[Smart Raka]\nAnyway, relax. The plan is still in motion.",
	"[Smart Raka]\nWhat we need to do next is to go back home. And to do that, we need to go to the train station.",
	"[Smart Raka]\nThere should be a bus stop down the embankment. I'm sure buses exist in this world so if we catch one, we might make it to the station safely."	
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

var pos_dialogues = [
	"[Smart Raka]\nMhm. Sure thing. We shouldn't plan to go immediately anyway. I'm sure you're still fatigued over what we just went through.",
	"[Strong Raka]\nWhew! Your muscles must be sore, eh Raka? Don't worry! Rest up for a bit and we can move onwards whenever you're ready!"
]

var pos_expressions = [
	"int-smile",
	"ath-laugh"
]

var neg_dialogues = [
	"[Strong Raka]\nWhoa whoa, no need to rush, your muscles must be sore, right, Raka?",
	"[Smart Raka]\nExactly, I didn't say we had to go now. Sigh, you always unneccesarily push yourself like this for no reason.",
	"[Raka]\nI'm not pushing myself. I'm perfectly fine.",
	"[Smart Raka]\nWouldn't hurt to at least know when to take care of yourself, y'know?",
	"[Raka]\n...Fine."
]

var neg_expressions = [
	"ath-sad",
	"int-annoyed",
	"def-sad",
	"int-angry",
	"def-neutral"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered", [button])
		button.connect("focus_entered", self, "_on_focus_entered", [button])
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS

var current_dialogue_index = -1
var negative_dialogue_index = -1
var positive_dialogue_index = -1

var negative_route = false
var positive_route = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)
		
	elif current_dialogue_index < dialogues.size() - 1:
		current_dialogue_index += 1
		animator.play(expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
	
	elif negative_route:
		if negative_dialogue_index < neg_dialogues.size() - 1:
			negative_dialogue_index += 1
			animator.play(neg_expressions[negative_dialogue_index])
			DialogueBoxManager.emit_signal("type", neg_dialogues[negative_dialogue_index])
		else:
			done = true
			
	elif positive_route:
		if positive_dialogue_index < pos_dialogues.size() - 1:
			positive_dialogue_index += 1
			animator.play(pos_expressions[positive_dialogue_index])
			DialogueBoxManager.emit_signal("type", pos_dialogues[positive_dialogue_index])
		else:
			done = true
			

	else:
		$up.visible = true
		$down.visible = true


func _on_button_entered(button):
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	$SelectSFX.play()
	
func _on_button_exited(button):
	button.mouse_default_cursor_shape = Control.CURSOR_ARROW

func _on_up_pressed():
	$up.visible = false
	$down.visible = false
	
	
	Relationship.amount = Relationship.amount + 2
	
	print("the amount is ")
	print(Relationship.amount)
	
	positive_route = true
	
func _on_down_pressed():
	$up.visible = false
	$down.visible = false
	
	Relationship.amount = Relationship.amount - 3
	
	print("the amount is ")
	print(Relationship.amount)
	
	negative_route = true
