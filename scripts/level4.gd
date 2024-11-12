extends Node2D

onready var player_cam = get_node("player/Camera2D")
onready var animator = $animate
onready var player = $player
onready var tween = $Tween
onready var fake_hedge = $fakeHedgeWall
onready var sparkle = $digGround/AnimatedSprite
onready var sledgehammer_area = $sledgehammerArea
onready var sledgehammer_pop_up = $SledgehammerPopUp
onready var dim_bg = $SledgehammerPopUp/ColorRect
onready var sledgehammer_sprite = $SledgehammerPopUp/Sprite
onready var pawprints = get_tree().get_nodes_in_group("pawprints")
onready var rocks = get_tree().get_nodes_in_group("rocks")
onready var cricket_sfx = preload("res://assets/sfx/ambience-night.mp3")
var dialogue_index_start = -1
var dialogue_index_hedge = 0
var dialogue_index_first_path = 0
var dialogue_index_second_path = 0
var dialogue_index_rock = 0
var dialogue_index_sledge = 0

var hedge_encounter = true
var first_rock_encounter = true
var first_path_encounter = true
var second_path_encounter = true
var sledgehammer_encounter = true

export (String) var next_scene

var dialogue_flags = {
	"hedge": false,
	"first_rock": false,
	"first_path": false,
	"second_path": false,
	"sledgehammer": false,
}

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

var first_rock_dialogues = [
	"[Raka]\nUh, there's... a rock.",
	"[Strong Raka]\nYou've gotta be kidding me! A stupid rock is blocking our way!",
	"[Smart Raka]\nWell what are you waiting for, break it.",
	"[Strong Raka]\nHey hey wait a minute! I might be the strong one here but even I can't destroy a goddamn rock with my bare hands!",
	"[Smart Raka]\nFair point.",
	"[Raka]\nSo now what should we do?",
	"[Smart Raka]\nHmm... If my hunch is true and this is not an ordinary maze... I think there should be an item somewhere that could help us break these rocks.",
	"[Strong Raka]\nWhat item? Like a rocket launcher?? Oh hell yeah!",
	"[Smart Raka]\nJust explore for now. We'll know it when we see it."
]

var first_path_dialogues = [
	"[Strong Raka]\nWOOO!!! Oh yeah, that felt good!",
	"[Smart Raka]\nIt's great that you're finally putting those muscles to good use. Now, let's continue forward.",
	"[Raka]\nUmm...",
	"[Raka]\nThe paths... they're splitting into two...",
	"[Smart Raka]\nIs this your first time seeing a maze?! Of course there's gonna be multiple paths. It wouldn't be a maze otherwise.",
	"[Raka]\nYeah, but... how do I know which way is the right way to go?",
	"[Strong Raka]\nWell I can't help you here. Maybe rely on your gut?",
	"[Raka]\nI... ",
	"[Raka]\nI can't do it. I need you guys to help me again... ",
	"[Smart Raka]\nSigh... let me handle this. I can still sense the cat's tracks, however I can only sense it for a short amount of time...",
	"[Smart Raka]\nSwitch to me so you'll know which path he took. Just be mindful that my power is limited.",	
]

var second_path_dialogues = [
	"[Raka]\nAnother branch... but wait, are all three of these paths... dead ends?",
	"[Smart Raka]\nRelax. Like I said, this might not be an ordinary maze.",
	"[Smart Raka]\nSometimes you gotta think outside the box.",
]

var sledgehammer_dialogues = [
	"[Raka]\nHang on... I see something bulging out of the ground. Is this it?",
	"[Smart Raka]\nIt appears so.",
	"[Strong Raka]\nAlright!! Let's dig and see what it is!",
	"[Smart Raka]\nOh?",
	"[Raka]\nIs this a sledgehammer?",
	"[Strong Raka]\nHoho that's perfect! It may not be a rocket launcher, but it can still get the job done!",
	"[Smart Raka]\nJust be careful while handling it.",
	"[Strong Raka]\nYeah yeah, party pooper. Alright! Let's go back to that rock!",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))
	player_cam.set_limit(MARGIN_LEFT, -50)
	player_cam.set_limit(MARGIN_RIGHT, 1460)
	player_cam.set_limit(MARGIN_BOTTOM, 710)
	Level4Manager.level4 = get_tree().current_scene
	Level4SFX.play_bgm(cricket_sfx, Level4SFX.bgm_player_2)
	sledgehammer_area.monitoring = false
	for rock in rocks:
		rock.connect("break_rock", self, "_on_break_rock", [rock])
	sledgehammer_pop_up.pause_mode = Node.PAUSE_MODE_PROCESS
	sparkle.pause_mode = Node.PAUSE_MODE_PROCESS
	tween.pause_mode = Node.PAUSE_MODE_PROCESS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_index_start < dialogues.size() - 1:
		animator.visible = true
		dialogue_index_start += 1
		animator.play(expressions[dialogue_index_start])
		DialogueBoxManager.emit_signal("type", dialogues[dialogue_index_start])
	else:
		animator.visible = false
		
	if dialogue_flags["hedge"]:
		dialogue_index_hedge += 1
		play_remainder_dialogue(hedge_encounter_dialogues, dialogue_index_hedge)
		
		
	if dialogue_flags["first_path"]:
		dialogue_index_first_path += 1
		play_remainder_dialogue(first_path_dialogues, dialogue_index_first_path)
		
		
	if dialogue_flags["second_path"]:
		dialogue_index_second_path += 1
		play_remainder_dialogue(second_path_dialogues, dialogue_index_second_path)
		
		
	if dialogue_flags["first_rock"]:
		dialogue_index_rock += 1
		play_remainder_dialogue(first_rock_dialogues, dialogue_index_rock)
		sledgehammer_area.monitoring = true
		sparkle.visible = true
		
	if dialogue_flags["sledgehammer"]:
		dialogue_index_sledge += 1
		play_remainder_dialogue(sledgehammer_dialogues, dialogue_index_sledge)
		
		if dialogue_index_sledge == 3:
			$digGround.visible = false
		
		if dialogue_index_sledge == 4:
			dim_bg.modulate.a = 0.0
			sledgehammer_sprite.modulate.a = 0.0
			sledgehammer_pop_up.visible = true
			tween.interpolate_property(dim_bg, "modulate:a", 0, 1.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.interpolate_property(sledgehammer_sprite, "modulate:a", 0, 1.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
		
		if dialogue_index_sledge == 7:
			tween.interpolate_property(dim_bg, "modulate:a", 1.0, 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.interpolate_property(sledgehammer_sprite, "modulate:a", 1.0, 0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			yield(get_tree().create_timer(1), "timeout")
			sledgehammer_pop_up.visible = false
			Level4Manager.has_sledgehammer = true
		
func play_initial_dialogue(dialogue, index, flag_key: String):
	player.is_active = true
	if dialogue.size() > 0:
		DialogueBoxManager.emit_signal('type', dialogue[index])
		dialogue_flags[flag_key] = true
		
func play_remainder_dialogue(dialogue, index):
	if Input.is_action_pressed("ui_accept"):
		if index < dialogue.size():
			DialogueBoxManager.emit_signal("type", dialogue[index])	
		
		
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
			play_initial_dialogue(hedge_encounter_dialogues, dialogue_index_hedge, "hedge")
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
			play_initial_dialogue(first_path_dialogues, dialogue_index_first_path, "first_path")
			first_path_encounter = false
		
func _on_secondPathEncounterArea_body_entered(body):
	if body.name == "player":
		if second_path_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_initial_dialogue(second_path_dialogues, dialogue_index_second_path, "second_path")
			second_path_encounter = false


func _on_nextSceneArea_body_entered(body):
	if body.name == "player":
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)


func _on_firstRockEncounter_body_entered(body):
	if body.name == "player":
		if first_rock_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_initial_dialogue(first_rock_dialogues, dialogue_index_rock, "first_rock")
			first_rock_encounter = false
			
func _on_sledgehammerArea_body_entered(body):
	if body.name == "player":
		if sledgehammer_encounter:
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_initial_dialogue(sledgehammer_dialogues, dialogue_index_sledge, "sledgehammer")
			sledgehammer_encounter = false
		
