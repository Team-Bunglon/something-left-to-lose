extends Node2D



onready var animator = $animate

var dialogues = [
"[Raka 3]\nWell, THAT, was terrifying.",
"[Raka 2]\nIt was quite.. difficult…",
"[Raka 3]\nOf course it was difficult!\nThis guy made it so much harder by refusing to cooperate!",
"[Raka]\nMe?!",
"[Raka 3]\nYes, you!",
"[Raka 3]\nDamn it Raka, you were so annoying!\nWas it THAT hard cooperating with us??",
"[Raka 3]\nHell, was it THAT tough to stop being so damn pessimistic!?",
"[Raka 2]\nHey. enough.",
"[Raka 3]\nAw, come on! don’t act like you didn't feel annoyed by him, I know you do.",
"[Raka 2]\n…. Yeah, honestly I did wish things turned out differently..",
"[Raka]\nWhat do you mean..?",
"[Raka 2]\nAfter talking to you for a while.. I do think that..",
"[Raka 2]\nI hate you, Raka.",
"[Raka 2]\nYou are so disappointing in so many ways..",
"[Raka 2]\nI wish you were smarter.",
"[Raka 2]\nI wish you were braver.",
"[Raka 2]\nI wish you were _͍̅ͩ̎͐͞",
"[Raka]\nHey.. are you okay…?",
"[Raka 3]\nYeah, he's right.",
"[Raka 3]\nIf only you  _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[Raka]\nGuys…?",
"[Raka 3]\n _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ w_͍̅ͩ̎͐͞ h_͍̅ͩ̎͐͞ y_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[Raka 3]\n _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞d _͍̅ͩ̎͐͞ o_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞n _͍̅ͩ̎͐͞t _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[Raka 2]\n _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞y _͍̅ͩ̎͐͞ o_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ u_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ ",
"[Raka]\nStop…",
"[ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞]\n _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _̅ͩ̎_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞]\n _͍̅ͩ̎͐͞_͍̅ͩ̎͐͞t _͍̅ͩ̎͐͞ r_͍̅ͩ̎͐͞ u_͍̅ͩ̎͐͞ s_͍̅ͩ̎͐͞t _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞]\n _͍̅ͩ̎͐͞u _͍̅ͩ̎͐͞ s_͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞ _͍̅ͩ̎͐͞",
"[Raka]\nPlease.. stop it…",
"[Raka]\n...Guys?…",
"[Raka]\n..Please… shut up...",
"[Raka]\n..Shut up",
"[Raka]\nShut up! Shut up!",
"[Raka]\nI can't take it anymore!",
"[Raka]\nSHUT UP!!!",
"[Raka]\nMAKE IT STOP!!!",
"[Raka]\nSTOP!! YOU'RE SCARING ME!!!",
"[Raka]\nLEAVE ME ALONE!!",
"....."
]

var expressions = [
"ath-sad",
"int-sad",
"ath-angry",
"def-shocked",
"ath-angry",
"ath-annoyed",
"ath-angry",
"int-angry",
"ath-angry",
"int-sad",
"def-neutral",
"int-sad",
"int-neutral",
"int-annoyed",
"int-sad",
"int-sad",
"int-blank",
"def-sad",
"ath-angry",
"ath-blank",
"def-neutral",
"ath-blank",
"ath-blank",
"int-blank",
"def-sad",
"int-blank",
"ath-blank",
"int-blank",
"def-sad",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	current_dialogue_index = -1
	pass

var current_dialogue_index = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if current_dialogue_index < dialogues.size() - 1:
		current_dialogue_index += 1
		if(current_dialogue_index >= 29):
			animator.hide()
		else:
			animator.play(expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		
	else:
		get_tree().change_scene("res://scenes/endings/bad-cutscene.tscn")

var done = false
