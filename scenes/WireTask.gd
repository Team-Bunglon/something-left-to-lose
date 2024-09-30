extends Node2D

onready var timer = $Timer
onready var label = $RichTextLabel
onready var time_seconds

func _ready():
	if PLAYER_STATES.currentState == 1:
		time_seconds = 10.0
	else:
		time_seconds = 5.0
	
	timer.wait_time = time_seconds
	timer.one_shot = true
	timer.connect("timeout", self, "_on_Timer_timeout")

	label.text = str(round(time_seconds)) + " Seconds Left"

	timer.start()

func _process(_delta):
	var time_left = max(0, timer.time_left)
	label.text = str(round(time_left)) + " Seconds Left"

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Deathscene_Wiretask.tscn")
