extends Node2D

onready var dialogbox = $dialoguebox

onready var pauseMenu = $PauseMenu

var dialogues = [
	"Hmmm... Where did the cat go? Is the door really closed? Is the blood pool still there?",
	"What now? Get some food, get energized, then?",
	"Whatever...",
	"I really hope the door doesn't accidentally get locked..",
]
var current_dialogue_index = 0

func _ready():
	pauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	print(PLAYER_STATES.stamina)
	if Level3Manager.first_time:
		if dialogues.size() > 0:
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])

func _process(delta):
	if PLAYER_STATES.stamina <= 0:
		Level3Manager.first_time = false
		PLAYER_STATES.decrease_stamina(10)
		get_tree().change_scene("res://scenes/level3/level3.tscn")
	if Level3Manager.first_time and Input.is_action_pressed("ui_accept"):
		if current_dialogue_index < dialogues.size() - 1:
			current_dialogue_index += 1
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		$PauseMenu.visible = true

