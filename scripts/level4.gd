extends Node2D

onready var player_cam = get_node("player/Camera2D")
onready var animator = $animate
onready var player = $player
onready var tween = $Tween
onready var pawprints = get_tree().get_nodes_in_group("pawprints")
var dialogue_index_start = -1
var dialogue_index_hedge = 0
var dialogue_index_second_path = -1

var hedge_encounter = true
var hedge_continue = false



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
	"ath-happy",
]

var hedge_encounter_dialogues = [
	"[Strong Raka]\n...",
	"[Raka]\nUhh...",
	"[Smart Raka]\nYou were saying?",
	"[Strong Raka]\n...Do we really have to go through this... maze?",
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

# not second path but final
var final_path_dialogues = [
	"[Raka]\nHuh? Is this a dead end?",
	"[Smart Raka]\nLooks like the cat tracks also end here...",
	"[Raka]\nThis is bad! Why is there no exit? How do we get out of here? HELP!!!!",
	"[Smart Raka]\n...",
	"[Smart Raka]\nThis is what I'm talking about. I had a hunch that this maze represents something you know all too well...", 
	"[Smart Raka]\n...your overwhelming thoughts.",
	"[Raka]\nMy... thoughts?",
	"[Smart Raka]\nMhm. Whenever you feel overwhelmed, you have this innate tendency to shut down and detach yourself from reality.",
	"[Smart Raka]\nAs such, you feel like you're not in control - like you've removed yourself from the problem and are now just a bystander who can't make any decisions.",
	"[Raka]\nBut... what else am I supposed to do? There's no way out!!",
	"[Strong Raka]\nOh ho, I get what you mean! Raka, it might seem like there's no way out, but that's because there isn't one yet. You need to make it by yourself!",
	"[Raka]\nI... I don't think I can.",
	"[Strong Raka]\nSure you can! It's not easy, but we're willing to help you. Just focus and carve your own path!",
	"[Smart Raka]\nJust imagine a long, straight line to the finish. On the count of 3, let's take a deep breath.",
	"[Raka]\n...Alright.",
	"[Raka]\n3...",
	"[Raka]\n2...",
	"[Raka]\n1....",
	"[Raka]\nInhale....",
	"[Raka]\nExhale....",
	"[Raka]\n....!!",	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))
	player_cam.set_limit(MARGIN_LEFT, -50)
	player_cam.set_limit(MARGIN_RIGHT, 1330)
	player_cam.set_limit(MARGIN_BOTTOM, 710)


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
		if Input.is_action_pressed("ui_accept"):
			if dialogue_index_hedge < hedge_encounter_dialogues.size() - 1:
				dialogue_index_hedge += 1
				DialogueBoxManager.emit_signal("type", hedge_encounter_dialogues[dialogue_index_hedge])
		
		
func play_hedge_dialogue():
	if hedge_encounter_dialogues.size() > 0:
		DialogueBoxManager.emit_signal("type", hedge_encounter_dialogues[dialogue_index_hedge])
		hedge_continue = true
		player.is_active = true
		
	
		
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
			player.is_active = false
			if player.current_state == PLAYER_STATES.STATES.DEFAULT:
				player.animated_sprite.play("default-side-idle")
			elif player.current_state == PLAYER_STATES.STATES.SMART:
				player.animated_sprite.play("intel-side-idle")
			else:
				player.animated_sprite.play("athlete-side-idle")
			yield(get_tree().create_timer(3), "timeout")
			play_hedge_dialogue()
			hedge_encounter = false
