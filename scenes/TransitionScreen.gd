extends CanvasLayer

export (bool) var start_transition = false
export (bool) var fast_transition = false

var fast_string = ""

signal finish_fade(anim_name)

func _ready():
	if start_transition:
		start_scene()
	else:
		$AnimationPlayer.play("normal")

	if fast_transition:
		fast_string = "_fast"

func change_scene(target):
	$AnimationPlayer.play("fade_to_black" + fast_string)
	yield($AnimationPlayer,"animation_finished")
	if target != "null":
		get_tree().change_scene(target)
		$AnimationPlayer.play("fade_to_normal" + fast_string) # This technically won't play as this script is stopped and unloaded when the current scene is changed

# Like start_scene, but without changing scene.
func end_scene():
	$AnimationPlayer.play("fade_to_black" + fast_string)

func start_scene():
	$AnimationPlayer.play("fade_to_normal" + fast_string)

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name in ["fade_to_normal", "fade_to_normal_fast"]:
		emit_signal("finish_fade", "start")
	elif anim_name in ["fade_to_black", "fade_to_black_fast"]:
		emit_signal("finish_fade", "end")
