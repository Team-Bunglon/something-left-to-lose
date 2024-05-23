extends Node2D



onready var animator = $animate

var dialogues = [
"[Raka 3]\nWE'RE FREE!",
"[Raka 2]\nFinally, some fresh air...\nGreat job, team.",
"[Raka 2]\nEspecially you, Raka",
"[Raka 3]\nHey, Raka, we totally nailed it in there!",
"[Raka]\nMe..?\nBut it was you guys who did all the work…",
"[Raka 2]\nWhat..? No, we–",
"[Raka 3]\nANYWAY! That was Terrifying!",
"[Raka 3]\nI swear I almost called for Mom while running from those ghosts!\nLet's never do that again!",
"[Raka 2]\nUgh, you keep cutting me off!",
"[Raka 2]\nBut yeah, I have to admit, it was pretty terrifying.\nI nearly passed out a few times.",
"[Raka]\nSame here…",
"[Raka 2]\nOf course you do, because you are us.",
"[Raka]\nYou guys keep saying we're that, but honestly, we're not.\nI'm just a nobody, while you two... \nYou're so confident and skilled. I could never be like that…",
"[Raka 3]\nOuch!",
"[Raka]\nWhat's up?",
"[Raka 3]\nI pushed myself too hard today.\nBrace yourself, Raka, you'll be sore tomorrow.",
"[Raka 3]\nMaybe now you'll see why exercise is important!",
"[Raka 2]\nSame here. My brain is definitely fried!",
"[Raka]\nWow... it seems like you all really overdid it.",
"[Raka 2]\nDid you think I could magically handle all those tasks?\nIt's all from your mind, you know.",
"[Raka 2]\nEven I can’t do rocket science!",
"[Raka]\nGuys...",
"[Raka 2]\nWhat we are saying is, our limits reflect ours,\nJust as our strengths mirror yours.",
"[Raka 2]\nEven our interactions and behaviors are a reflection of you.",
"[Raka 3]\nI represent your more... carefree side.\nThe part of you that wants to let go and embrace spontaneity.\nBut I can also be selfish and indifferent to others.",
"[Raka 2]\nI am your skeptical side.\nThe way I talk down to him and you mirror how you talk down to yourself.",
"[Raka 2]\nYet, I sense your yearning to improve, Raka.\nTo showcase your—and our—best self to the world.",
"[Raka 2]\nThat is what started my “plan” at first..\nI just want you to focus on something take your mind off those…\nHorrible things you say about yourself.",
"[Raka 2]\nAnd maybe... you'll realize your true worth, and potential.",
"[Raka]\nCan somebody like me do that...",
"[Raka 2]\nRaka, we can either be the monsters that haunt your darkest thoughts,\nOr we can be your greatest allies.",
"[Raka 2]\nYou created us to shield yourself from the world,\nTo embody different aspects of your personality.",
"[Raka 3]\nWe feel what you feel, and we genuinely want to support you, Raka.",
"[Raka 3]\nHelp us be better friends to you. Trust us.",
"[Raka 2]\nWe can work through your past and your pain together, as one",
"[Raka 3]\nAnd maybe one day, we'll just become one person.",
"[Raka 2]\nCan you imagine it? the you who is intelligent and strong",
"[Raka 3]\nFree and not ashamed to be yourself, even love yourself?",
"[Raka 3]\nHow great would that be!",
"[Raka]\nThank you, everyone.. genuinely…\nIf that's how the future will be...",
"[Raka]\nI can't wait."
]

var expressions = [
"ath-laugh",
"int-neutral",
"int-smile",
"ath-laugh",
"def-neutral",
"int-sad",
"ath-sad",
"ath-laugh",
"int-annoyed",
"int-smile",
"def-smile",
"int-smile",
"def-sad",
"ath-angry",
"def-shocked",
"ath-sad",
"ath-laugh",
"int-sigh",
"def-neutral",
"int-sigh",
"int-smile",
"def-neutral",
"int-smile",
"int-neutral",
"ath-neutral",
"int-sad",
"int-smile",
"int-sad",
"int-smile",
"def-neutral",
"int-neutral",
"int-neutral",
"ath-neutral",
"ath-happy",
"int-smile",
"ath-neutral",
"int-smile",
"ath-happy",
"ath-laugh",
"def-smile",
"def-happy"
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
		animator.play(expressions[current_dialogue_index])
		DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		
	else:
		get_tree().change_scene("res://scenes/WinCondition_good.tscn")

var done = false
