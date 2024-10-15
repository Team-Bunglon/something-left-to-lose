extends Node2D

## The path to the next scene after this scene finished playing.
export (String, FILE) var next_scene

var current_dialogue_index = 0
var dialogues_level02 = [
	"[Second Voice]\nThat monster ain't got game on me. What's next?",
	"[First Voice]\nLook at that safe! It's got to be the least secure safe ever made. Doesn't take that long to figure out the password.",
	"[Second Voice]\nSo I'll rip the door open and...",
	"[First Voice]\nNo no no... Let Raka figure it out. I've hidden the passcode around the room. It shouldn't be that hard for a small brain like him.",
]

func _ready():
	PLAYER_STATES.keySFX = $KeySFX
	PLAYER_STATES.paperSFX = $PaperSFX
	$CanvasModulate.visible = true
	if self.name == "Level02":
		current_dialogue_index = 0
		DialogueBoxManager.emit_signal("type", dialogues_level02[current_dialogue_index])

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		if self.name == "Level02":
			_advance_dialogue(dialogues_level02)

func _advance_dialogue(current_dialogue):
	if current_dialogue_index < current_dialogue.size() - 1:
		current_dialogue_index += 1
		DialogueBoxManager.emit_signal("type", current_dialogue[current_dialogue_index])

func _on_NextLevel_body_entered(body:Node):
	if "player" in body.name.to_lower():
		body.is_active = false
		$TransitionScreen.change_scene(next_scene)

func _on_LocksafeUI_success():
	$WallFG/Locksafe.unlock()
	$WallFG/Locksafe.interact()
	DialogueBoxManager.emit_signal("type", "You open the safe.")
