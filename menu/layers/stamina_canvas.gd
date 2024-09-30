extends CanvasLayer

onready var stamina_bar = $StaminaBar

func _ready():
	PLAYER_STATES.connect("decrease_stamina", self, "on_player_decrease_stamina")

func on_player_decrease_stamina(stamina):
	stamina_bar.set_health(stamina)
