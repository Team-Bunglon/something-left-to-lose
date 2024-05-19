extends Node2D

var idle_timer := Timer.new()
var blood_timer := Timer.new()

func _ready():
	add_child(idle_timer)
	add_child(blood_timer)
	
	idle_timer.connect("timeout", self, "_on_idle_timer_timeout")
	blood_timer.connect("timeout", self, "_on_blood_timer_timeout")

	idle_timer.wait_time = 1.7
	idle_timer.one_shot = true
	idle_timer.start()

	$AnimationPlayer.play("death-anim")
	$Char.visible = true
	$BloodSplat.visible = false

func _on_idle_timer_timeout():
	$Char.visible = false
	$BloodSplat.visible = true
	
	blood_timer.wait_time = 1
	blood_timer.one_shot = true
	blood_timer.start()

	$AnimationPlayer.play("blood-splat")

func _on_blood_timer_timeout():
	var TransitionScreen1 = get_node("TransitionScreen1")
	TransitionScreen1.change_scene("res://scenes/Level2Lanjutan.tscn")
