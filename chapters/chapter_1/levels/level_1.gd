extends Node2D

var sandi_locker = ""
var rng = RandomNumberGenerator.new()
onready var kertas_sandi = $kertassandi

onready var level1BGM = $LightHumBGM

onready var pauseMenu = $PauseMenu

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	$CanvasModulate.visible = true
	level1BGM.play()
	level1BGM.pause_mode = Node.PAUSE_MODE_PROCESS
	pauseMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	sandi_locker = _generate_sandi()
	###
	# Ini masih perlu ganti instance tujuan harusnya
	kertas_sandi.set_sandi(sandi_locker)
	#$tembok2/vending_machine.set_sandi(sandi_locker)
	###
	
	DialogueBoxManager.emit_signal("type", """The door is locked.
	You don't know if the key even exists.""")
	
func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		get_tree().paused = true
		$PauseMenu.visible = true

func _generate_sandi():
	var sandi = ""
	for i in range(0,5):
		var char_type_decision = rng.randi()%2
		var alphabet = rng.randi_range(48,57)
		if char_type_decision==1:
			alphabet = rng.randi_range(65,90)
		sandi+=char(alphabet)
	return sandi
		
		
		
		
		
		
		
