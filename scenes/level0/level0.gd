extends Node2D
class_name Level0

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene
export (NodePath) var player_path

var current_dialogue_index = 0
var dialogues_level0C = [
	"[Second Voice]\nThat monster ain't got game on me. What's next?",
	"[First Voice]\nLook at that safe! It's got to be the least secure safe ever made. Doesn't take that long to figure out the password.",
	"[Second Voice]\nSo I'll rip the door open and...",
	"[First Voice]\nNo no no... Let Raka figure it out. I've hidden the passcode around the room. It shouldn't be that hard for a small brain like him.",
]

var player: Player

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	player = get_node_or_null(player_path) # We use _or_null variant since not all level0 needs player for its interaction.
	$CanvasModulate.visible = true
	if self.name == "Level0C":
		current_dialogue_index = 0
		DialogueBoxManager.emit_signal("type", dialogues_level0C[current_dialogue_index])

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		if self.name == "Level0C":
			_advance_dialogue(dialogues_level0C)

func _advance_dialogue(current_dialogue):
	if current_dialogue_index < current_dialogue.size() - 1:
		current_dialogue_index += 1
		DialogueBoxManager.emit_signal("type", current_dialogue[current_dialogue_index])

func _on_NextLevel_body_entered(body:Node):
	if "player" in body.name.to_lower():
		body.deactivate()
		$TransitionScreen.change_scene(next_scene)

func _on_LocksafeUI_success():
	$WallFG/Locksafe.unlock()
	$WallFG/Locksafe.interact()
	DialogueBoxManager.emit_signal("type", "You open the safe.")
