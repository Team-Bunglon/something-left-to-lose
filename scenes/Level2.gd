extends Node2D

onready var dialogbox = $dialoguebox
onready var animator = $animate
onready var pauseMenu = $PauseMenu

var dialogues = [
	"I think I am done for the day.",
	"Sun is getting low, I should head back home soon.",
]
var expressions = [
	"def-neutral",
	"def-neutral",
]
var current_dialogue_index = 0

func _ready():
	$CanvasModulate.visible = true
	$tembok2/player/AudioStreamPlayer2D.stream = load("res://assets/sfx/level2/ambience-level2.mp3")
	$tembok2/player/AudioStreamPlayer2D.play()
	
	animator.visible = true
	$tembok2/player/Light2D.visible = false
	
	pauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	
	if dialogues.size() > 0:
		animator.play("def-neutral")
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if current_dialogue_index == 1:
		animator.visible = false
		$tembok2/player/Light2D.visible = true

	if Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			animator.play(expressions[current_dialogue_index])
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
			
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		pauseMenu.visible = true
		
