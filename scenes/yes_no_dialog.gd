extends PopupMenu

enum ChoiceIds{
	YES = 1,
	NO = 0
}

signal choice_made()

onready var menu = $"."

var item_on_deciding

func _ready():
	menu.add_check_item("Yes", ChoiceIds.YES)
	menu.add_check_item("No", ChoiceIds.NO)

func _on_yes_no_dialogbox_id_pressed(id):
	if id == ChoiceIds.YES:
		DialogueBoxManager.emit_signal("add_item",item_on_deciding)
		DialogueBoxManager.emit_signal("done_typing")
	else:
		DialogueBoxManager.emit_signal("done_typing")

func _on_yes_no_dialogbox_popup_hide():
	DialogueBoxManager.emit_signal("done_typing")
