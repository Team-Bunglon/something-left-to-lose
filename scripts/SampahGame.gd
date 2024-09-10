extends Control

export (NodePath) var kotak_sampah_path
var kotak_sampah


func _ready():
	kotak_sampah = get_node(kotak_sampah_path)
	kotak_sampah.connect("open", self, "show")
	

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		hide()
	
func show():
	if SampahManager.firstTime:
		DialogueBoxManager.emit_signal("type", "Drag the items around by using the left mouse button.")
	$"../../tembok2/player".is_active = false
	visible = true
	
func hide():
	$"../../tembok2/player".is_active = true
	visible = false
	SampahManager.firstTime = false
	PLAYER_STATES.check_paper_count()


func _on_Exit_button_pressed():
	hide()
