extends Node2D

func _ready():
	$AnimationPlayer.play("intro")

func _on_AnimationPlayer_animation_finished(anim_name:String):
	print(anim_name)
	print("I AM DONE IDIOT!!!")

