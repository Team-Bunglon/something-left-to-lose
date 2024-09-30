extends ProgressBar

onready var timer = $Timer
onready var transition_bar = $"."
onready var stamina_value = $StaminaValue

export var health = 0

func set_health(new_health):
	var prev_health = stamina_value.value
	health = min(stamina_value.max_value, new_health)
	stamina_value.value=health
	
	if health<prev_health:
		if timer.is_stopped():
			timer.start()
		
func init_health(health):
	self.health = health
	
	stamina_value.max_value=health
	stamina_value.value=health
	
	transition_bar.max_value=health
	transition_bar.value=health

func set_max_health(new_max_health):
	stamina_value.max_value=new_max_health
	transition_bar.max_value=new_max_health

func _on_Timer_timeout():
	transition_bar.value=stamina_value.value
