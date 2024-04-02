extends Node

var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 0.75
var time_passed = 0.0

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == button:
		pressCount += 1
		score += 5
		update_display()

func _process(delta):
	time_passed += delta
	
	# score decrement every interval if score < 100
	if time_passed >= decrement_interval and score < 100:
		score -= 10
		time_passed = 0.0
		
		if score <= 0:
			score = 0
			
		update_display()
	
	# score top limit at 100
	if score >= 100:
		score = 100
		update_display()

func update_display():
	$CounterDisplay.text = "Score: " + str(score)
