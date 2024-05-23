extends Node

onready var animated_sprite = $AnimatedSprite
onready var closedDoor = $Closed
onready var halfDoor = $Half
onready var openDoor = $Open
onready var camera = $Camera2D
onready var timer = Timer.new()
onready var player_state = PLAYER_STATES.currentState
onready var player_stamina = PLAYER_STATES.stamina
onready var transition_screen = $TransitionScreen1

var is_first_time = true
var button = KEY_SPACE
var pressCount = 0
var score = 0
var decrement_interval = 0.75
var time_passed = 0.0

# animation map for progress bar
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
var is_started = false # boolean to flag the starting condition for player lose
var can_input = true # boolean to flag if player can input, set as limit if score >= 100

func _ready():
	first_condition()
	timer.wait_time = 1.25
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")

func _input(event):
	if can_input == true:
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
	
	if is_first_time == true:
		DialogueBoxManager.emit_signal("type", "Press the SPACEBAR rapidly to open the door!")
		is_first_time = false
		
	# score decrement every interval if score < 100
	if time_passed >= decrement_interval and score < 100:
		score -= 10
		time_passed = 0.0
		if score <= 0:
			score = 0
			if is_started == true:
				PLAYER_STATES.decrease_stamina(player_stamina)
				get_tree().change_scene("res://scenes/level3/level3.tscn")
		update_display()

func update_display():
	# conditions based on score
	if score >= 15:
		is_started = true
	if score >= 50:
		half_condition()
	if score >= 98:
		complete_condition()
	if score >= 100:
		score = 100
		can_input = false
		timer.start()
		

	# progress bar
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

func _on_timer_timeout() -> void:
	#transition_screen.change_scene("res://scenes/WinCondition_good.tscn")
	print("Total Relationship")
	print(Relationship.amount)
	if(Relationship.amount > 0):
		transition_screen.change_scene("res://scenes/endings/good-dialogue.tscn")
	else:
		transition_screen.change_scene("res://scenes/endings/bad-dialogue.tscn")
