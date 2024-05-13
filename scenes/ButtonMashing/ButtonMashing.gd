extends Node

onready var animated_sprite = $AnimatedSprite
onready var closedDoor = $Closed
onready var halfDoor = $Half
onready var openDoor = $Open
onready var camera = $Camera2D
onready var player_state = PLAYER_STATES.currentState
onready var player_stamina = PLAYER_STATES.stamina

export var stamina_decrement = 1

var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 0.75
var time_passed = 0.0
var score_anim_map = {
	0: "default",
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
var is_started = false

func _ready():
	first_condition()

func _input(event):
	if event is InputEventKey and event.pressed == false and event.scancode == button and player_state == 2:
		pressCount += 1
		score += 5
		camera._on_button_pressed()
		update_display()
	elif event is InputEventKey and event.pressed == false and event.scancode == button:
		pressCount += 1
		score += 3
		camera._on_button_pressed()
		update_display()
		if score >= 50:
			decrement_interval = 0.7

func _process(delta):
	time_passed += delta
	
	# score decrement every interval if score < 100
	if time_passed >= decrement_interval and score < 100:
		score -= 10
		time_passed = 0.0
		if score <= 0:
			score = 0
			if is_started == true:
				player_stamina-=stamina_decrement
				PLAYER_STATES.decrease_stamina(player_stamina)
				get_tree().change_scene("res://scenes/level3/level3.tscn")
		update_display()
	
	if score >= 15:
		is_started = true
	
	# score top limit at 100
	if score >= 100:
		score = 100
		update_display()

func update_display():
	if score >= 50:
		half_condition()
	if score >= 98:
		complete_condition()
	if score == 100:
		
		# TODO
		pass
		
		
	$CounterDisplay.text = "Score: " + str(score) + " counter: " + str(pressCount)

	if score_anim_map.has(score):
		animated_sprite.play(score_anim_map[score])

func first_condition():
	closedDoor.visible = true
	halfDoor.visible = false
	openDoor.visible = false
	
func half_condition():
	closedDoor.visible = false
	halfDoor.visible = true
	openDoor.visible = false
	
func complete_condition():
	closedDoor.visible = false
	halfDoor.visible = false
	openDoor.visible = true	
