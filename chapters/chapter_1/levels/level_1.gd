extends Node2D
class_name Chapter1Level1

## The path to the next scene after this scene finished playing.
export (String, FILE, "*.tscn") var next_scene

onready var password_paper = $PasswordPaper
onready var level_1_bgm = $LightHumBGM
onready var pause_menu = $PauseMenu
onready var vending = $Wall/VendingMachine

# The password that the vending machine sets.
var password_vending = ""

func _ready():
	$CanvasModulate.visible = true
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	
	level_1_bgm.play()
	level_1_bgm.pause_mode = Node.PAUSE_MODE_PROCESS
	pause_menu.pause_mode = Node.PAUSE_MODE_PROCESS

	# TODO: Set randomized password
	password_vending = _generate_password()
	password_paper.set_password(password_vending)
	#vending.set_password(password_vending)
	vending.set_next_scene(next_scene)
	
	DialogueBoxManager.emit_signal("type", """You are trapped in the bathroom.
	Find a way to escape from this floor!""")
	
func _process(_delta):
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		$PauseMenu.visible = true

func _generate_password():
	var password = ""
	for _i in range(0,5):
		var char_type_decision = randi()%2
		var alphabet = randi() % 10 + 48
		if char_type_decision == 1:
			alphabet = randi() % 26 + 65
		password += char(alphabet)
	return password
		
		
		
		
		
		
		
