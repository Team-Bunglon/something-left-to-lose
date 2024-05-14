extends Node2D

onready var timer = Timer.new()
onready var light = $player/Light2D
onready var transition_screen = $TransitionScreen1

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_one_shot(true)

func _on_timer_timeout():
	transition_screen.change_scene("null")

func _on_FirstLayer_body_entered(body):
	if body.get_name() == "player":
		timer.wait_time = 3.0
		timer.start()
