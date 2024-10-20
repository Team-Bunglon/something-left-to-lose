extends CanvasLayer

class_name ExamineScene

# The name of the scene. Useful for differentiating between scenes in code.
export (String) var scene_name

# The message box that appears when interacting. Leave this empty to simply hide the textbox.
export (String, MULTILINE) var scene_message = ""

# The expression that may appear in the scene. Leave this empty to hide it.
export (String) var expression = ""

# Mirror the expression. Useful when the character is interacting with a mirror.
export (bool) var mirror_expression = false

# The background image of the scene.
export (Texture) var background_sprite

# The foreground image of the scene.
export (Texture) var filter_sprite

# The NodePath to an object that activates the examine scene. Required.
export (NodePath) var object_path

# The NodePath to the player object in order to temporarily stop any input towards him. Required.
export (NodePath) var player_path

var can_show: bool = true
var can_hide: bool = false
var player: Player
var object

func _ready():
	object = get_node(object_path)
	object.connect("open", self, "show")
	player = get_node(player_path)

	$AnimationPlayer.play("RESET")
	if background_sprite != null:
		$Background.texture = background_sprite
	if filter_sprite != null:
		$Filter.texture = filter_sprite

	if mirror_expression:
		$Expression.flip_h = true

	if expression != "":
		$Expression.visible = true
		$Expression.play(expression)
	else:
		$Expression.play("none")
		$Expression.visible = false

func _input(event):
	if (event.is_action_pressed("space") or event.is_action_pressed("enter")) and can_hide:
		hide()

func show():
	if not can_show:
		return
	can_show = false
	player.inactive()
	$AnimationPlayer.play("show_scene")

func hide():
	can_hide = false
	$AnimationPlayer.play("hide_scene")

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "show_scene":
		if scene_message == "":
			can_hide = true
		else:
			DialogueBoxManager.emit_signal("type", scene_message)
			hide()
	elif anim_name == "hide_scene":
		can_show = true
		player.active()
