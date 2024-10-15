extends Node2D

onready var player_cam = get_node("player/Camera2D")


var dialogues = [
	"[Raka]\nSomehow we ended up here... in this park.",
	"[Strong Raka]\nWOO!! I love parks. I didn't know we had one this huge within this campus!",
	"[Smart Raka]\nPipe down, you dorks. We'll lose sight of the cat.",
	"[Strong Raka]\nHey hey, lighten up! We've been able to keep up so far. This is a piece of cake!"
]

var hedge_encounter_dialogues = [
	"[Strong Raka]\n...",
	"[Raka]\nUhh...",
	"[Smart Raka]\nYou were saying?",
	"[Strong Raka]\n...Do we really have to go through this?"
]



# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam.set_zoom(Vector2(0.19,0.19))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
