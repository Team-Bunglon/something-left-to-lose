extends Node2D

var sandi_locker = ""

onready var kertas_sandi = $kertassandi
onready var level1BGM = $LightHumBGM
onready var pauseMenu = $PauseMenu
onready var vending = $Wall/VendingMachine

func _ready():
	$CanvasModulate.visible = true
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	level1BGM.play()
	level1BGM.pause_mode = Node.PAUSE_MODE_PROCESS
	pauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS

	# TODO: Set randomized password
	sandi_locker = _generate_sandi()
	kertas_sandi.set_sandi(sandi_locker)
	#vending.set_password(sandi_locker)
	
	DialogueBoxManager.emit_signal("type", """You are trapped in the bathroom.
	Find a way to escape from this floor!""")
	
func _process(_delta):
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		$PauseMenu.visible = true

func _generate_sandi():
	var sandi = ""
	for _i in range(0,5):
		var char_type_decision = randi()%2
		var alphabet = randi() % 10 + 48
		if char_type_decision==1:
			alphabet = randi() % 26 + 65
		sandi+=char(alphabet)
	return sandi
		
		
		
		
		
		
		
