extends Node2D

onready var timer = Timer.new()
onready var light = $player/Light2D
onready var transition_screen = $TransitionScreen1
onready var dialogbox = $dialoguebox
onready var player_vignette = $player/Camera2D/Vignete

var dialogues = [
	["At last, the air fills my lungs with hope, not despair.",
	"I take the path less traveled by, to the left."],
	["With every step, clarity dawns,", 
	"the shadows lift and I embrace the light,",
	"no longer just a wanderer,",
	"but a keeper of all that I still have something left to lose."]]

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
		timer.wait_time = 1.5
		timer.start()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues[curr_dia].size() - 1 :
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])
		elif current_dialogue_index == 3 and curr_dia == 1:
			print(current_dialogue_index, curr_dia)
			get_tree().change_scene("res://scenes/Scenery/Main Menu.tscn")

func finaldia():
	curr_dia = 1
	current_dialogue_index = 0
	DialogueBoxManager.emit_signal("type", dialogues[curr_dia][current_dialogue_index])
