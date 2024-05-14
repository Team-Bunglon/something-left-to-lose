extends ProgressBar

onready var timer = $Timer
onready var transitionbar = $"."
onready var staminavalue = $staminavalue

export var health = 0

func set_health(new_health):
	var prev_health = staminavalue.value
	health = min(staminavalue.max_value, new_health)
	staminavalue.value=health
	
	if health<prev_health:
		if timer.is_stopped():
			timer.start()
		
func init_health(health):
	self.health = health
	
	staminavalue.max_value=health
	staminavalue.value=health
	
	transitionbar.max_value=health
	transitionbar.value=health

func set_max_health(new_max_health):
	staminavalue.max_value=new_max_health
	transitionbar.max_value=new_max_health

func _on_Timer_timeout():
	transitionbar.value=staminavalue.value
