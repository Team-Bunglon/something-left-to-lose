extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var stamina_label = $staminalabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _ready():
	stamina_label.text = "stamina 10"
	PLAYER_STATES.connect("decrease_stamina",self, "on_player_decrease_stamina")


func on_player_decrease_stamina(stamina):
	stamina_label.text = "stamina "+str(stamina)
