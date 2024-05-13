extends Sprite

var _sandi_text = ""
onready var label = $Label

func set_sandi(sandi):
	_sandi_text=sandi
	label.text = _sandi_text
