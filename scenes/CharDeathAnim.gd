extends Node2D

export var defaut_restart_scene = "res://scenes/Level2Lanjutan.tscn"
onready var restart_button = $CanvasLayer/RestartButton

func _ready():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("death-anim")

func _on_RestartButton_button_down():
	restart_button.visible = false
	if PLAYER_STATES.restart_path.empty():
		$TransitionScreen1.change_scene(defaut_restart_scene)
	else:
		print("RESTART USING PLAYER_STATES")
		$TransitionScreen1.change_scene(PLAYER_STATES.restart_path)

