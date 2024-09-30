extends Sprite

# Paper that contains password.
class_name PasswordPaper

onready var label = $Label
var _password_text = ""

func on_ready():
	label.text = _password_text

func set_password(pass):
	_password_text = pass
	label.text = _password_text
