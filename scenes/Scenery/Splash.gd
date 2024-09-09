extends Node2D

export var can_skip:bool = false

onready var anim_tree = get_node("AnimationTree")
onready var splash = anim_tree["parameters/playback"]
onready var anim_index = 1

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and can_skip:
		$Timer.stop() # Timers start when splash starts (set on $AnimationPlayer)
		splash.travel("fade" + str(anim_index))
		anim_index += 1
	pass

func _on_Timer_timeout():
	splash.travel("fade" + str(anim_index))
	anim_index += 1
	pass 

func _change_scene():
	return get_tree().change_scene("res://scenes/pre-levels/opening.tscn")
