extends Node2D

onready var cat = $AnimalCat
onready var cat_anim = cat.get_node("AnimatedSprite")
onready var raka = $player

var move_speed = 100

func _ready():
	$doubledorr_hadapsisi.open()
	cat_anim.play("running-right")
	
