extends Node2D

var sandi_locker = ""
var first_time_enter = true
var dialogue_continue = false
var current_dialogue_index = 0
var prev_offset: Vector2
var rng = RandomNumberGenerator.new()
onready var kertas_sandi = $kertassandi
onready var level_1_BGM = $LightHumBGM
onready var pause_menu = $PauseMenu
onready var player = $tembok2/player
onready var player_cam = $tembok2/player/Camera2D
onready var tween = $Tween
onready var barrier = $Barrier

var dialogues = [
	"[Raka]\nUhm, why is there a vending machine in the middle of the room?",
	"[Strong Raka]\nBeats me... Oh I know! We need to destroy it!",
	"[Smart Raka]\nNo you nitwit... this is related to the items I've hidden. Once we collect enough of them and piece them together, it'll reveal a code.",
	"[Raka]\nA code?",
	"[Smart Raka]\nYep. just input that code using the vending machine's keypad, and the exit doors should open.",
	"[Strong Raka]\nI'm not good at overly brainy stuff like that, but if you need to speed up the searching process, switch to me so you can sprint!\n (Press '3' to use his power)",
	"[Smart Raka]\nHahah, and once you do find them... if you can't decipher the code, let me handle it.\n (Press '2' to use his power)"
]

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	level_1_BGM.play()
	level_1_BGM.pause_mode = Node.PAUSE_MODE_PROCESS
	tween.pause_mode = Node.PAUSE_MODE_PROCESS
	pause_menu.pause_mode = Node.PAUSE_MODE_PROCESS
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
		pause_menu.visible = true
	if dialogue_continue == true:
		if Input.is_action_pressed("ui_accept"):
			if current_dialogue_index < dialogues.size() - 1:
				current_dialogue_index += 1
				DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
	if current_dialogue_index == 6:
		tween.interpolate_property(player_cam, "offset", player_cam.offset, prev_offset, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
			
				
func play_vending_dialogue():
	barrier.queue_free()
	prev_offset = player_cam.offset
	var target_offset = prev_offset + Vector2(-100, 0)
	
	tween.interpolate_property(player_cam, "offset", prev_offset, target_offset, 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	if dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		dialogue_continue = true
		
	

func _generate_sandi():
	var sandi = ""
	for i in range(0,5):
		var char_type_decision = rng.randi()%2
		var alphabet = rng.randi_range(48,57)
		if char_type_decision==1:
			alphabet = rng.randi_range(65,90)
		sandi+=char(alphabet)
	return sandi
	
func _on_VendingMachineArea_body_entered(body):
	if body.name == "player":
		if first_time_enter:
			play_vending_dialogue()
			first_time_enter = false
			
		
