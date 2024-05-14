extends CanvasLayer


onready var staminabar = $staminabar

func _ready():
	PLAYER_STATES.connect("decrease_stamina",self, "on_player_decrease_stamina")

func on_player_decrease_stamina(stamina):
	staminabar.set_health(stamina)
