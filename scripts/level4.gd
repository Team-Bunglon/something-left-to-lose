extends Node2D

onready var player_cam = get_node("player/Camera2D")
onready var animator = $animate
onready var player = $player
onready var tween = $Tween
onready var fake_hedge = $fakeHedgeWall
onready var pawprints = get_tree().get_nodes_in_group("pawprints")
onready var rocks = get_tree().get_nodes_in_group("rocks")
var dialogue_index_start = -1
var dialogue_index_hedge = 0
var dialogue_index_first_path = 0
var dialogue_index_second_path = 0

var hedge_encounter = true
var hedge_continue = false

var first_path_encounter = true
var first_path_continue = false

var second_path_encounter = true
var second_path_continue = false

export (String) var next_scene



var dialogues = [
	"[Raka]\nSomehow we ended up here... in this park.",
	"[Strong Raka]\nWOO!! I love parks. I didn't know we had one this huge within this campus!",
	"[Smart Raka]\nPipe down, you dorks. We'll lose sight of the cat.",
	"[Strong Raka]\nHey hey, lighten up! We've been able to keep up so far. This is a walk in the park! Literally!"
]

var expressions = [
	"def-neutral",
	"ath-happy",
	"int-annoyed",
	"ath-laugh",
]

var hedge_encounter_dialogues = [
	"[Strong Raka]\n...",
	"[Raka]\nUhh...",
	"[Smart Raka]\nYou were saying?",
	"[Strong Raka]\n...Is this... is this a goddamn hedge maze??",
	"[Raka]\nWhy is there a huge maze like this in the park?",
	"[Strong Raka]\nI don't know, and it seems we can't get around it...",
	"[Smart Raka]\nSo the only way is through. Alright, keep your eyes peeled, something tells me this isn't going to be some ordinary maze.",
	"[Raka]\nHow so..?",
	"[Smart Raka]\nFor now, let's just keep going.",
]

var first_path_dialogues = [
	"[Raka]\nThere's two paths... how do I know which one's the right one?",
	"[Smart Raka]\nLet me handle this. I can still sense the cat's tracks, however I can only sense it for a short amount of time...",
	"[Smart Raka]\nSwitch to me so you'll know which path he took. Just be mindful that my power is limited.",
	"[Strong Raka]\nAnd I see some rocks blocking our path up ahead! Switch to me and I'll break them all!"
]

var second_path_dialogues = [
	"[Raka]\nAnother branch... but wait, are all three of these paths... dead ends?",
	"[Smart Raka]\nRelax. Like I said, this might not be an ordinary maze.",
	"[Smart Raka]\nSometimes you gotta think outside the box.",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))
	player_cam.set_limit(MARGIN_LEFT, -50)
	player_cam.set_limit(MARGIN_RIGHT, 1330)
	player_cam.set_limit(MARGIN_BOTTOM, 710)
	Level4Manager.level4 = get_tree().current_scene
	
	for rock in rocks:
		rock.connect("break_rock", self, "_on_break_rock", [rock])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_index_start < dialogues.size() - 1:
		animator.visible = true
		dialogue_index_start += 1
		animator.play(expressions[dialogue_index_start])
		DialogueBoxManager.emit_signal("type", dialogues[dialogue_index_start])
	else:
		animator.visible = false
		
	if hedge_continue:
		play_remainder_dialogue(hedge_encounter_dialogues, dialogue_index_hedge)
		dialogue_index_hedge += 1
		
	if first_path_continue:
		play_remainder_dialogue(first_path_dialogues, dialogue_index_first_path)
		dialogue_index_first_path += 1
		
	if second_path_continue:
		play_remainder_dialogue(second_path_dialogues, dialogue_index_second_path)
		dialogue_index_second_path += 1
		
func play_remainder_dialogue(dialogue, index):
	if Input.is_action_pressed("ui_accept"):
		if index < dialogue.size():
			DialogueBoxManager.emit_signal("type", dialogue[index])	
		
func play_hedge_dialogue():
	player.is_active = true
	if hedge_encounter_dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", hedge_encounter_dialogues[dialogue_index_hedge])
		dialogue_index_hedge += 1
		hedge_continue = true
		
		
func play_first_path_dialogue():
	player.is_active = true
	if first_path_dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", first_path_dialogues[dialogue_index_first_path])
		dialogue_index_first_path += 1
		first_path_continue = true
		
func play_second_path_dialogue():
	player.is_active = true
	if second_path_dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", second_path_dialogues[dialogue_index_second_path])
		dialogue_index_second_path += 1
		second_path_continue = true
	
func fake_wall_hide():
	tween.interpolate_property(fake_hedge, "modulate:a", 1.0, 0.2, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func fake_wall_show():
	tween.interpolate_property(fake_hedge, "modulate:a", 0.2, 1.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
		
func _on_break_rock(rock):
	$RockBreakSFX.play() 

func show_pawprints():
	for pawprint in pawprints:
		pawprint.visible = true
		pawprint.modulate.a = 0.0
		tween.interpolate_property(pawprint, "modulate:a", 0.0, 1.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(get_tree().create_timer(1.5), "timeout")
	
	for pawprint in pawprints:
		tween.interpolate_property(pawprint, "modulate:a", 1.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
		
func _on_hedgeEncounterArea_body_entered(body):
	if body.name == "player":
		if hedge_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(3), "timeout")
			play_hedge_dialogue()
			hedge_encounter = false


func _on_hiddenPassage_body_entered(body):
	if body.name == "player":
		fake_wall_hide()

func _on_hiddenPassage_body_exited(body):
	if body.name == "player":
		fake_wall_show()

func _on_firstPathEncounterArea_body_entered(body):
	if body.name == "player":
		if first_path_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_first_path_dialogue()
			first_path_encounter = false
		
func _on_secondPathEncounterArea_body_entered(body):
	if body.name == "player":
		if second_path_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_second_path_dialogue()
			second_path_encounter = false


func _on_nextSceneArea_body_entered(body):
	if body.name == "player":
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)
