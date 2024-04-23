extends CanvasLayer

func change_scene(target):
	$AnimationPlayer.play("fade_to_black")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play("fade_to_normal")
