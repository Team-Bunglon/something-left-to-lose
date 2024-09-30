extends Control

# One of the game's mechanic where you have to drag around trash in order to find the item the player is looking for.
class_name ClutterGame

export (NodePath) var target_path
export (NodePath) var player_path

var target: Node2D
var player: Player

func _ready():
	player = get_node(player_path)
	target = get_node(target_path)
	target.connect("open", self, "show")
	
func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		hide()
	
func show():
	if ClutterManager.first_time:
		DialogueBoxManager.emit_signal("type", "Drag the items around by using the left mouse button.")
	ClutterManager.first_time = false
	player.is_active = false
	visible = true
	
func hide():
	player.is_active = true
	visible = false
	PLAYER_STATES.check_paper_count()

func _on_Exit_button_pressed():
	hide()
