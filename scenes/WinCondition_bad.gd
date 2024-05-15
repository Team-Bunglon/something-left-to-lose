extends Node2D

onready var timer = Timer.new()
onready var light = $player/Light2D
onready var transition_screen = $TransitionScreen1
onready var dialogbox = $dialoguebox

var dialogues = [["This place feels weird. I can't breathe.",
	"This feeling told me to go right...",
	"...for the only right thing i've ever done.",
	"hahaha... silly me."], ["If I die here, no one will ever know.",
	"What a peaceful death.",
	"For the one...", 
	"who got nothing left to lose."]]
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

func finaldia():
	curr_dia = 1
	current_dialogue_index = 0
	DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])
