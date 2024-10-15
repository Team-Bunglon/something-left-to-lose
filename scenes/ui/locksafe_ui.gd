extends Control
class_name Locksafe

export (NodePath) var locksafe_path
export (NodePath) var player_path
export var password = "9023"

var can_type = true
var is_success = false
var shown_secret = false
var locksafe
var player

# Emited when the input password is correct
signal success()

func _ready():
	locksafe = get_node(locksafe_path)
	locksafe.connect("open_locksafe", self, "show")
	player = get_node(player_path)
	$Label.set("custom_colors/font_color",Color(1.0, 1.0, 1.0, 1.0))
	$Label.text = ""

# Set the password for the locksafe.
func set_password(new_pass):
	password = new_pass

func show():
	player.is_active = false
	visible = true

func hide(active_player=true):
	$Label.set("custom_colors/font_color",Color(1.0, 1.0, 1.0, 1.0))
	$Label.text = ""
	player.is_active = active_player
	visible = false

func _physics_process(_delta):
	if is_success:
		$Debug.text = "YOU DID IT!"
	else:
		$Debug.text = str($Timer.time_left)

func _show_success():
	$SuccessSound.play()
	$Label.set("custom_colors/font_color",Color(0.0, 1.0, 0.0, 1.0))
	$Label.text = "CORRECT"
	$SuccessDelay.start()

func _show_fail(message="INCORRECT"):
	$FailSound.play()
	$Label.set("custom_colors/font_color",Color(1.0, 0.0, 0.0, 1.0))
	$Label.text = message
	$FailDelay.start()

func _show_secret():
	shown_secret = true
	$SecretSound.play()
	$Label.set("custom_colors/font_color",Color(1.0, 0.0, 0.0, 1.0))
	$Label.text = "GRAND DAD"
	$FailDelay.start()

func _type(letter):
	if not can_type:
		return
	$Label.set("custom_colors/font_color",Color(1.0, 1.0, 1.0, 1.0))
	$ClickSound.play()
	if not $Label.text.is_valid_integer():
		$Label.text = ""
	if len($Label.text) < 4:
		$Label.text += letter

func _back():
	if not can_type:
		return
	if not $Label.text.is_valid_integer():
		$Label.text = ""
	$BackSound.play()
	$Label.text = $Label.text.left(len($Label.text) - 1)

func _check_pass():
	if $Label.text == "":
		$EnterSound.play()
		return
	elif $Label.text == "INCORRECT" or is_success or not can_type:
		return
	$EnterSound.play()
	can_type = false
	$LED.frame = 1
	$Timer.start()

func _input(event):
	if not can_type or not visible:
		return
	if event.is_action_pressed("1"):
		_type("1")
	elif event.is_action_pressed("2"):
		_type("2")
	elif event.is_action_pressed("3"):
		_type("3")
	elif event.is_action_pressed("4"):
		_type("4")
	elif event.is_action_pressed("5"):
		_type("5")
	elif event.is_action_pressed("6"):
		_type("6")
	elif event.is_action_pressed("7"):
		_type("7")
	elif event.is_action_pressed("8"):
		_type("8")
	elif event.is_action_pressed("9"):
		_type("9")
	elif event.is_action_pressed("0"):
		_type("0")
	elif event.is_action_pressed("backspace"):
		_back()
	elif event.is_action_pressed("enter"):
		_check_pass()
	elif event.is_action_pressed("esc") and can_type:
		hide()

func _on_ButtonBack_button_down():
	_back()

func _on_ButtonEnter_button_down():
	_check_pass()

func _on_Button0_button_down():
	_type("0")

func _on_Button1_button_down():
	_type("1")

func _on_Button2_button_down():
	_type("2")

func _on_Button3_button_down():
	_type("3")

func _on_Button4_button_down():
	_type("4")

func _on_Button5_button_down():
	_type("5")

func _on_Button6_button_down():
	_type("6")

func _on_Button7_button_down():
	_type("7")

func _on_Button8_button_down():
	_type("8")

func _on_Button9_button_down():
	_type("9")

func _on_Timer_timeout():
	$Timer.stop()
	if $Label.text == password:
		_show_success()
	elif $Label.text in ["69", "420", "666"]:
		_show_fail("WOW FUNNY")
	elif $Label.text == "777":
		_show_fail("NOT LUCKY")
	elif $Label.text == "1337":
		_show_fail("HACK FAIL")
	elif $Label.text == "7777" and not shown_secret:
		_show_secret()
	else:
		_show_fail()

func _on_SuccessDelay_timeout():
	$SuccessDelay.stop()
	$OpenSound.play()
	is_success = true
	hide(false)
	emit_signal("success")

func _on_FailDelay_timeout():
	$FailDelay.stop()
	can_type = true
	$LED.frame = 0

func _on_ButtonExit_button_down():
	if can_type:
		hide()
