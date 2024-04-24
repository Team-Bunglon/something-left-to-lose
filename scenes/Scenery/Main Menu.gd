extends CanvasLayer

onready var SettingIconAnim = $SettingIconAnim
onready var SettingIcon = $SettingIcon
onready var SettingBox = $SettingBox

var is_setting = true

func _on_TextureButton2_pressed():
	print("anjay")


func _on_ExitIcon_pressed():
	get_tree().quit()


func _on_SettingIcon_pressed():
	SettingCheck()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func SettingCheck():
	if is_setting == true:
		SettingTrue()
	else:
		SettingFalse()

func SettingTrue():
	SettingIconAnim.visible = true
	SettingIcon.visible = false
	SettingIconAnim.play("Rotation")
	SettingBox.visible = true
	is_setting = false

func SettingReset():
	SettingIcon.visible = true
	SettingIconAnim.visible = false

func SettingFalse():
	SettingIconAnim.visible = true
	SettingIcon.visible = false
	SettingIconAnim.play("Rotation")
	SettingBox.visible = false
	is_setting = true
