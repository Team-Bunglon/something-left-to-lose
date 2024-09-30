extends Node2D

onready var options_menu = get_node("CanvasLayer2/Options")
onready var credits_menu = get_node("CanvasLayer3/Credits")
onready var main_menu_bgm = $MainMenuBGM

var sfx_options : bool = false
onready var buttons = get_tree().get_nodes_in_group("button")

export (String) var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu_bgm.volume_db = 0
	get_tree().paused = false
	$VBoxContainer/PlayButton.grab_focus()
	
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered", [button])
		button.connect("focus_entered", self, "_on_focus_entered", [button])
		button.connect("mouse_exited", self, "_on_button_exited", [button])
		button.connect("focus_exited", self, "_on_focus_exited", [button])
			
	options_menu.pause_mode = Node.PAUSE_MODE_PROCESS
	credits_menu.pause_mode = Node.PAUSE_MODE_PROCESS
	main_menu_bgm.pause_mode = Node.PAUSE_MODE_PROCESS
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS
	$AnimatedSprite.pause_mode = Node.PAUSE_MODE_PROCESS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
			
func change_mouse_filter(filter):
	for button in buttons:
			button.mouse_filter = filter
			button.modulate = Color(1,1,1,1)

func change_focus_filter(filter):
	for button in buttons:
			button.focus_mode = filter
	
func _on_button_entered(button):
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.modulate = Color(1.2, 1.2, 1.2, 1)
	if not sfx_options:
		$SelectSFX.play()
	
func _on_button_exited(button):
	button.modulate = Color(1, 1, 1, 1)
	button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	
func _on_focus_entered(button):
	button.modulate = Color(1.2, 1.2, 1.2, 1)
	if not sfx_options:
		$SelectSFX.play()

func _on_focus_exited(button):
	button.modulate = Color(1,1,1,1)

func _on_Options_closed_menu():
	get_tree().paused = false
	change_mouse_filter(Control.MOUSE_FILTER_STOP)
	change_focus_filter(Control.FOCUS_ALL)
	sfx_options = false
	

func _on_Credits_closed_menu():
	get_tree().paused = false
	change_mouse_filter(Control.MOUSE_FILTER_STOP)
	change_focus_filter(Control.FOCUS_ALL)
	sfx_options = false


func _on_PlayButton_gui_input(event):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept"):
		$Tween.interpolate_property(main_menu_bgm, "volume_db", 0, -30, 1.00, 1, Tween.EASE_IN, 0)
		$Tween.start()
		$TransitionScreen1.visible = true
		$TransitionScreen1.change_scene(next_scene)


func _on_OptionsButton_gui_input(event):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept"):
		options_menu.visible = true
		get_tree().paused = true
		change_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		change_focus_filter(Control.FOCUS_NONE)
		sfx_options = true

func _on_CreditsButton_gui_input(event):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept"):
		credits_menu.visible = true
		get_tree().paused = true
		change_mouse_filter(Control.MOUSE_FILTER_IGNORE)
		change_focus_filter(Control.FOCUS_NONE)
		sfx_options = true

func _on_QuitButton_gui_input(event):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed) or event.is_action_pressed("ui_accept"):
		get_tree().quit()
