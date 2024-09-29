extends Node2D

export (String) var next_scene

func _ready():
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(_anim_name:String):
	return get_tree().change_scene(next_scene)

