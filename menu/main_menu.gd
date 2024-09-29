extends Node2D

onready var optionsMenu = get_node("CanvasLayer2/Options")
onready var creditsMenu = get_node("CanvasLayer3/Credits")
onready var mainMenuBGM = $MainMenuBGM

var sfxOptions : bool = false

export (String) var next_scene

# TODO: Give access to movement guide from this screen.
func _ready():
	mainMenuBGM.volume_db = 0
	get_tree().paused = false
	var buttons = get_tree().get_nodes_in_group("button")
	$PlayButton.grab_focus()
				
	for button in buttons:
		button.connect("mouse_entered", self, "_on_button_entered")
		button.connect("focus_entered", self, "_on_focus_entered")
			
	optionsMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	creditsMenu.pause_mode = Node.PAUSE_MODE_PROCESS
	mainMenuBGM.pause_mode = Node.PAUSE_MODE_PROCESS
	$SelectSFX.pause_mode = Node.PAUSE_MODE_PROCESS
	$AnimatedSprite.pause_mode = Node.PAUSE_MODE_PROCESS


func _on_PlayButton_pressed():
	$Tween.interpolate_property(mainMenuBGM, "volume_db", 0, -30, 1.00, 1, Tween.EASE_IN, 0)
	$Tween.start()
	$TransitionScreen1.visible = true
	$TransitionScreen1.change_scene(next_scene)

func _on_QuitButton_pressed():
	get_tree().quit()
	
func _on_button_entered():
	if not sfxOptions:
		$SelectSFX.play()

func _on_focus_entered():
	if not sfxOptions:
		$SelectSFX.play()

func _on_OptionsButton_pressed():
	optionsMenu.visible = true
	get_tree().paused = true
	disable_buttons(true)
	sfxOptions = true
	
func _on_CreditsButton_pressed():
	creditsMenu.visible = true
	get_tree().paused = true
	disable_buttons(true)
	sfxOptions = true
	
func disable_buttons(disable: bool):
	var buttons = get_tree().get_nodes_in_group("button")
	for button in buttons:
		button.disabled = disable

func _on_Options_closedMenu():
	get_tree().paused = false
	disable_buttons(false)
	sfxOptions = false

func _on_Credits_closedMenu():
	get_tree().paused = false
	disable_buttons(false)
	sfxOptions = false
