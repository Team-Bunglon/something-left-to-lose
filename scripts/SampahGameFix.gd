# This is a fixed version of SampahGame where the player node is not hardcoded
# I'll fix this in Level 1 later.
extends Control

export (NodePath) var kotak_sampah_path
export (NodePath) var player_path
var kotak_sampah
var player


func _ready():
	kotak_sampah = get_node(kotak_sampah_path)
	kotak_sampah.connect("open", self, "show")
	player = get_node(player_path)

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		hide()
	
func show():
	if SampahManager.firstTime:
		DialogueBoxManager.emit_signal("type", "Drag the items around by using the left mouse button.")
	player.is_active = false
	visible = true
	
func hide():
	player.is_active = true
	visible = false
	SampahManager.firstTime = false
	PLAYER_STATES.check_paper_count()


func _on_Exit_button_pressed():
	hide()
