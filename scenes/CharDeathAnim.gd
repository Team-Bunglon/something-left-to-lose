extends Node2D

export var defaut_restart_scene = "res://scenes/Level2Lanjutan.tscn"
onready var restart_button = $CanvasLayer/RestartButton

func _ready():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("death-anim")

func _on_RestartButton_button_down():
	restart_button.visible = false
	if PLAYER_STATES.restart_path.empty():
		DialogueBoxManager.mark_second_encounter(defaut_restart_scene)
		$TransitionScreen1.change_scene(defaut_restart_scene)
	else:
		print("RESTART USING PLAYER_STATES")
		DialogueBoxManager.mark_second_encounter(PLAYER_STATES.restart_path)
		$TransitionScreen1.change_scene(PLAYER_STATES.restart_path)
		

