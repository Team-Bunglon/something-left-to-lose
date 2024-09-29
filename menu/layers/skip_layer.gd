extends CanvasLayer

onready var is_skipping = false

## The delay until the player can hold the skip button since the start of the cutscene .
export (int) var delay = 1

## The path to the next scene after this scene finished playing.
export (String) var next_scene

func _ready():
	$Timer.wait_time = delay
	$Timer.start()

func _input(event):
	if not $Timer.is_stopped():
		return
	if event.is_action_pressed("ui_accept"):
		is_skipping = true
	elif event.is_action_released("ui_accept"):
		is_skipping = false

func _process(_delta):
	if is_skipping and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("skipping")
	elif not is_skipping and $AnimationPlayer.is_playing():
		$AnimationPlayer.play("RESET")

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "skipping":
		print("Pretend something is changed")
		get_tree().change_scene(next_scene)
