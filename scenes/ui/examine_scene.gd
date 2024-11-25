extends CanvasLayer

class_name ExamineScene

# The name of the scene. Useful for differentiating between scenes in code.
export (String) var scene_name

# Enable scene to be hidden when pressing "ui_accept". If disabled, you need to manually hide it in the code.
export (bool) var can_hide_manually = true

# The message box that appears when interacting. Leave this empty to simply hide the textbox.
export (String, MULTILINE) var scene_message = ""

# The expression that may appear in the scene. Leave this empty to hide it.
export (String) var expression = ""

# Mirror the expression. Useful when the character is interacting with a mirror.
export (bool) var mirror_expression = false

# The background image of the scene.
export (Texture) var background_sprite

# The foreground image of the scene.
export (Texture) var foreground_sprite

# The filter image to apply.
export (Texture) var filter_sprite

# The NodePath to an object that activates the examine scene. Required.
export (NodePath) var object_path

# The NodePath to the player object in order to temporarily stop any input towards him. Required.
export (NodePath) var player_path

var can_show: bool = true
var can_hide: bool = false
var player: Player
var object

# Emmited when the scene is shown fully.
signal scene_shown

# Emmited when the scene is hidden fully.
signal scene_hidden

# Emmited when the scene is shown half-way.
signal scene_shown_half

# Emmited when the scene is hidden half-way.
signal scene_hidden_half

func _ready():
	object = get_node(object_path)
	object.connect("open", self, "show")
	player = get_node(player_path)

	$AnimationPlayer.play("RESET")
	if background_sprite != null:
		$Background.texture = background_sprite
	if foreground_sprite != null:
		$Foreground.texture = foreground_sprite
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
	
	self.visible = false

func _unhandled_input(event):
	if (event.is_action_pressed("space") or event.is_action_pressed("enter")) and can_hide and can_hide_manually:
		hide()

func show(half=false):
	if not can_show:
		return
	can_show = false
	player.inactive()
	if not half:
		$AnimationPlayer.play("show_scene")
	else:
		$AnimationPlayer.play("show_scene_half")

func hide(half=false):
	can_hide = false
	if not half:
		$AnimationPlayer.play("hide_scene")
	else:
		$AnimationPlayer.play("hide_scene_half")

func force_hide():
	$AnimationPlayer.play("RESET")
	self.visible = false
	$ColorRect.visible = false
	can_hide = false

func _on_AnimationPlayer_animation_finished(anim_name:String):
	if "show_scene" in anim_name:
		if scene_message == "":
			can_hide = true
		else:
			DialogueBoxManager.emit_signal("type", scene_message)
			hide()
		if anim_name == "show_scene":
			emit_signal("scene_shown")
		elif anim_name == "show_scene_half":
			emit_signal("scene_shown_half")
	elif anim_name == "hide_scene":
		can_show = true
		player.active()
		emit_signal("scene_hidden")
	elif anim_name == "hide_scene_half":
		emit_signal("scene_hidden_half")
