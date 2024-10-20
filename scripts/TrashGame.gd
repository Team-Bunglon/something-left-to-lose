extends Control

# This is a fixed version of SampahGame where the player node is not hardcoded
# I'll fix this in Level 1 later. And ensure that everything is in English.
class_name TrashGame

# The NodePath to an object that activates the trash game. Note that it doesn't have to physically be a trash can, any container works. E.g. toilet, table, safe, etc.
export (NodePath) var trash_bin_path

# The NodePath to the player object in order to temporarily stop any input towards him.
export (NodePath) var player_path

var trash_bin
var player


func _ready():
	trash_bin = get_node(trash_bin_path)
	trash_bin.connect("open", self, "show")
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
