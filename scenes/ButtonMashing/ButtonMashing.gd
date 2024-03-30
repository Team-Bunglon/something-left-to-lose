extends Node

var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 1.0
var time_passed = 0.0

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == button:
		pressCount += 1
		score += 1
		update_display()

func _process(delta):
	time_passed += delta
	if time_passed >= decrement_interval and score > 0:
		score -= 1
		time_passed = 0.0
		update_display()

func update_display():
	$CounterDisplay.text = "Score: " + str(score)
