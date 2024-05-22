extends Node2D

var idle_timer := Timer.new()
var electrocuted_timer := Timer.new()
var restart_menu_timer := Timer.new()
onready var restart_button = get_node("TransitionScreen1/Control/RestartButton_Wiretask")

func _ready():
	add_child(idle_timer)
	add_child(electrocuted_timer)
	add_child(restart_menu_timer)
	
	idle_timer.connect("timeout", self, "_on_idle_timer_timeout")
	electrocuted_timer.connect("timeout", self, "_on_electrocuted_timer_timeout")
	restart_menu_timer.connect("timeout", self, "_on_restart_menu_timer_timeout")

	idle_timer.wait_time = 1.7
	idle_timer.one_shot = true
	idle_timer.start()

	$Char.visible = true
	$AnimationPlayer.play("death-anim")

func _on_idle_timer_timeout():
	$Char.visible = false
	$Electrocuted.visible = true
	
	electrocuted_timer.wait_time = 0.5
	electrocuted_timer.one_shot = true
	electrocuted_timer.start()

	$AnimationPlayer.play("electrocuted")

func _on_electrocuted_timer_timeout():
	$Electrocuted.visible = false
	$BloodOverlay.visible = true
	
	restart_menu_timer.wait_time = 0.6
	restart_menu_timer.one_shot = true
	restart_menu_timer.start()
	
	$AnimationPlayer.play("blood-overlay")
	
func _on_restart_menu_timer_timeout():
	restart_button.visible = true
