extends Node

var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 1.0
var time_passed = 0.0

onready var animated_sprite = $AnimatedSprite

var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 0.75
var time_passed = 0.0
var score_anim_map = {
	5: "1",
	10: "2",
	15: "3",
	20: "4",
	25: "5",
	30: "6",
	35: "7",
	40: "8",
	45: "9",
	50: "10",
	55: "11",
	60: "12",
	65: "13",
	70: "14",
	75: "15",
	80: "16",
	85: "17",
	90: "18",
	95: "19",
	100: "20"
}

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

	if score_anim_map.has(score):
		animated_sprite.play(score_anim_map[score])
