extends Node2D

onready var timer = Timer.new()
onready var light = $player/Light2D
onready var transition_screen = $TransitionScreen1
onready var dialogbox = $dialoguebox

var dialogues = [
	["They're so loud... so relentless...",
	"And i can feel the others chasing me again...",
	"They are all the same.",
	"This place is suffocating. It's hard to breathe.",
	 "An impulse urges me to the right...",
	 "...perhaps this is the only way to run away from them."], 
	["Should I perish here, the world will remain unaware.",
	 "What a tranquil way to go.",
	 "For someone...",
	 "who has nothing left to lose."]
]

var current_dialogue_index = 0
var curr_dia = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_one_shot(true)
	
	# for dialogue
	if dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])

func _on_timer_timeout():
	transition_screen.change_scene("null")
	light.dimming()

func _on_FirstLayer_body_entered(body):
	if body.get_name() == "player":
		timer.wait_time = 3.0
		timer.start()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues[curr_dia].size() - 1 :
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])
		elif current_dialogue_index == dialogues[-1].size() - 1:
			get_tree().change_scene("res://scenes/endings/bad-transition.tscn")

func finaldia():
	curr_dia = 1
	current_dialogue_index = 0
	DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])
