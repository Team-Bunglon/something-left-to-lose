extends Node

var bgm_player
var bgm_player_2
var tween


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm_player = AudioStreamPlayer2D.new()
	add_child(bgm_player)
	bgm_player.pause_mode = Node.PAUSE_MODE_PROCESS
	bgm_player.bus = "BGM"
	
	bgm_player_2 = AudioStreamPlayer2D.new()
	add_child(bgm_player_2)
	bgm_player_2.pause_mode = Node.PAUSE_MODE_PROCESS
	bgm_player_2.bus = "BGM"

func play_bgm(stream: AudioStream, bgm_player):
	bgm_player.stream = stream
	bgm_player.play()

func stop_bgm(bgm_player):
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(bgm_player, "volume_db", bgm_player.volume_db, -30, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	tween.connect("tween_completed", tween, "_queue_free")
