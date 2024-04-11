## INI HARUSNYA PUNYA LOKER

extends transparancable_object

onready var command_line = $line_wrapper/LineEdit
var _sandi = ""

func _ready():
	command_line.visible=false

func set_sandi(sandi):
	_sandi=sandi

func interact():
	command_line.visible=true

func _on_LineEdit_text_entered(new_text):
	if new_text.to_lower()==_sandi.to_lower():
		print("berhasil")
