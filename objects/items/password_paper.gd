extends Sprite

# Paper that contains password.
class_name PasswordPaper

onready var label = $Label
var _password_text = ""

func on_ready():
	label.text = _password_text

func set_password(password):
	_password_text = password
	label.text = _password_text
