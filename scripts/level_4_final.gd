extends Node2D

onready var player_cam = get_node("player/Camera2D")
onready var animator = $animate
onready var player = $player
onready var flash_canvas = $flashCanvas
onready var flash = $flashCanvas/flash
onready var tween = $Tween
onready var exit_area = $ExitMazeArea

var final_path_encounter = true
var final_path_continue = false
var exit_encounter = true
var exit_continue = false
var dialogue_index_final_path = 0
var dialogue_index_exit = 0
var dialogue_done = false

export (String) var next_scene
signal dialogue_finished

var final_path_dialogues = [
	"[Raka]\nHuh? Is this another dead end?",
	"[Smart Raka]\nLooks like the cat tracks also end here...",
	"[Strong Raka]\nAnd don't think I could tear down this shrub... it's too hard!",
	"[Raka]\nThis is bad! Why is there no exit? How do we get out of here? HELP!!!!",
	"[Smart Raka]\n...",
	"[Smart Raka]\nThis is what I'm talking about. I had a hunch that this maze represents something you know all too well...", 
	"[Smart Raka]\n...your overwhelming thoughts.",
	"[Raka]\nMy... thoughts?",
	"[Smart Raka]\nMhm. Whenever you feel overwhelmed, you have this innate tendency to shut down and detach yourself from reality.",
	"[Smart Raka]\nAs such, you feel like you're not in control - like you've removed yourself from the problem and are now just a bystander who can't make any decisions.",
	"[Smart Raka]\nThose cat tracks I saw... in truth, you could've seen them too Raka. However at your level, your concentration isn't astute enough... so, you rely on your smart alternative.",
	"[Strong Raka]\nAnd those rocks I smashed... you could've easily broken through them too, haha! You just currently lack the determination and strength... so, you rely on your strong alternative.",
	"[Raka]\nBut... what else am I supposed to do?? I can't do this on my own...",
	"[Strong Raka]\nOh ho, I get what you mean! Raka, it might seem like you can't do anything by yourself... but now's the perfect time to prove that wrong!",
	"[Raka]\nWhat do you mean?",
	"[Strong Raka]\nWell, you manifested this maze...", 
	"[Smart Raka]\nSo that means you can also manifest the maze's exit.",
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

var final_path_expressions = [
	"def-neutral",
	"int-sigh",
	"ath-sad",
	"def-shocked",
	"int-neutral",
	"int-sad",
	"int-sad",
	"def-sad",
	"int-neutral",
	"int-sad",
	"int-smile",
	"ath-happy",
	"def-neutral",
	"ath-laugh",
	"def-shocked",
	"ath-happy",
	"int-smile",
	"def-sad",
	"ath-laugh",
	"int-smile",
	"def-smile",
]

var exit_dialogues = [
	"[Raka]\n...",
	"[Raka]\nI... did it....",
	"[Strong Raka]\nWould you look at that! I knew you can do it!",
	"[Smart Raka]\nYeah, needless to say, I'm quite impressed.",
	"[Raka]\nI couldn't have done it without you guys...",
	"[Strong Raka]\nHey, hey! That was all your doing, Raka! You deserve all the credit.",
	"[Smart Raka]\nIndeed. You kept your focus and managed to clear your head.", 
	"[Smart Raka]\nThere will be a lot more hurdles in the future, Raka. We won't be there for all of them, so you need to learn to protect yourself.",
	"[Raka]\nYeah... I will. I will keep learning.",
	"[Strong Raka]\nAlright, let's keep going!! That cat couldn't have gone too far!",
]

var exit_expressions = [
	"def-shocked",
	"def-smile",
	"ath-laugh",
	"int-smile",
	"def-smile",
	"ath-happy",
	"int-smile",
	"int-neutral",
	"def-smile",
	"ath-happy",
	
]

# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))
	player_cam.set_limit(MARGIN_LEFT, -50)
	player_cam.set_limit(MARGIN_RIGHT, 660)
	player_cam.set_limit(MARGIN_TOP, -200)
	player_cam.set_limit(MARGIN_BOTTOM, 340)
	flash.modulate.a = 0.0
	exit_area.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if final_path_continue:
		play_remainder_dialogue(final_path_dialogues, dialogue_index_final_path)
		if dialogue_index_final_path < 21:
			animator.play(final_path_expressions[dialogue_index_final_path])
		else:
			animator.visible = false
		dialogue_index_final_path += 1
		
	if dialogue_index_final_path == final_path_dialogues.size() + 1:
		dialogue_done = true
		emit_signal("dialogue_finished")
	
	if dialogue_done:
		player.shake_camera(10, 0.5)
		yield(get_tree().create_timer(1.4), "timeout")
		player.stop_camera_shake()
	
	if exit_continue:
		player.is_active = true
		play_remainder_dialogue(exit_dialogues, dialogue_index_exit)
		if dialogue_index_exit > exit_dialogues.size() - 1:
			animator.visible = false
			exit_continue = false  
		else:
			animator.play(exit_expressions[dialogue_index_exit])
		if Input.is_action_pressed("ui_accept"):
			dialogue_index_exit += 1
			
func _on_dialogue_finished():
	yield(get_tree().create_timer(1.4), "timeout")
	flash_screen()
	if $hedgeIllusion:
		$hedgeIllusion.queue_free()
	yield(get_tree().create_timer(5.0), "timeout")
	flash_canvas.visible = false
	player.is_active = true
	dialogue_done = false
	final_path_continue = false
	exit_area.monitoring = true
	
	
	
func flash_screen():
	flash_canvas.visible = true
	tween.interpolate_property(flash, "modulate:a", 0.0, 1.0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	tween.interpolate_property(flash, "modulate:a", 1.0, 0.0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	

func play_remainder_dialogue(dialogue, index):
	if Input.is_action_pressed("ui_accept"):
		if index < dialogue.size():
			DialogueBoxManager.emit_signal("type", dialogue[index])	
	
func play_final_path_dialogue():
	if final_path_dialogues.size() > 0:
		animator.visible = true
		animator.play(final_path_expressions[dialogue_index_final_path])
		DialogueBoxManager.emit_signal("type", final_path_dialogues[dialogue_index_final_path])
		dialogue_index_final_path += 1
		final_path_continue = true
		
func play_exit_dialogue():
	if exit_dialogues.size() > 0:
		animator.position.x += 10
		animator.visible = true
		animator.play(exit_expressions[dialogue_index_exit])
		DialogueBoxManager.emit_signal("type", exit_dialogues[dialogue_index_exit])
		dialogue_index_exit += 1
		exit_continue = true

func _on_FinalPathEncounterArea_body_entered(body):
	if body.name == "player":
		if final_path_encounter:
			player.is_active = false
			player.make_player_idle()
			yield(get_tree().create_timer(1), "timeout")
			play_final_path_dialogue()
			final_path_encounter = false



func _on_ExitMazeArea_body_entered(body):
	if body.name == "player":
		if exit_encounter:
			player.is_active = false
			player.make_player_idle()
			play_exit_dialogue()
			exit_encounter = false


func _on_FinalArea_body_entered(body):
	if body.name == "player":
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)
