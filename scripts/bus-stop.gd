extends Node2D

onready var player = $player
onready var animator = $animate
onready var cat = $AnimalCat
onready var cat_animate = cat.get_node("AnimatedSprite")
export (String) var next_scene 
var yield_finish = false
var done = false
var current_dialogue_index = -1
var cat_done = false
var dialogue_cont_index = -1



var dialogues = [
	"[Raka]\nUmm...",
	"[Raka]\nHow much longer do we have to wait?",
	"[Smart Raka]\nAny minute now. The yellow bus will definitely come.",
	"[Strong Raka]\nHey, uh. I don't know if you noticed, but we've been waiting here for 45 minutes.",
	"[Smart Raka]\nThere... might be some delays.",
	"[Raka]\nAre you... sure?",
	"[Smart Raka]\n...",
	"[Smart Raka]\nIt seems I may have been wrong.",
	"[Strong Raka]\nUGH!! Let's just walk! I'm getting so impatient!",
	"[Smart Raka]\nNow now, it just so happens that there's a lot to this realm that I wasn't aware of.",
	"[Smart Raka]\nSince the bus isn't coming, I think it's safe to say that this world is devoid of other living creatures."
	
]

var expressions = [
	'def-neutral',
	'def-sad',
	'int-neutral',
	'ath-annoyed',
	'int-annoyed',
	'def-neutral',
	'int-annoyed',
	'int-sigh',
	'ath-angry',
	'int-smile',
	'int-neutral'
]

var dialogues_continue = [
	"[Smart Raka]\nExcept for...",
	"[Raka]\nThe CAT!! Where is he running to?!",
	"[Strong Raka]\nWHOOHOO you don't have to tell me twice, let's follow it!"
]

var expressions_continue = [
	"int-happy",
	"def-shocked",
	"ath-happy"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	player.animated_sprite.play("default-front-idle")
	player.is_active = false
	yield(get_tree().create_timer(5), "timeout")
	yield_finish = true
	
	
	
func _process(delta):
	if yield_finish:
		if current_dialogue_index < dialogues.size() - 1:
			animator.visible = true
			current_dialogue_index += 1
			animator.play(expressions[current_dialogue_index])
			DialogueBoxManager.emit_signal("type", dialogues[current_dialogue_index])
		
		else:
			on_dialogue_finished()
	
	if cat_done:
		if dialogue_cont_index < dialogues_continue.size() - 1:
			animator.visible = true
			dialogue_cont_index += 1
			animator.play(expressions_continue[dialogue_cont_index])
			DialogueBoxManager.emit_signal("type", dialogues_continue[dialogue_cont_index])
		
func on_dialogue_finished():
	var cat_script = load("res://scripts/cat_bus_stop.gd")
	if cat_script:
		cat.set_script(cat_script)
		cat.set_process(true)
		animator.visible = false
		cat_animate.play("running-right")
		yield(get_tree().create_timer(3), "timeout")
		cat_done = true
	
	
		
			
	
