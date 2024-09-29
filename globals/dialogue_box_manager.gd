# To display a dialogue, call the following line: 
# [code]DialogueBoxManager.emit_signal("signal", "messages to put on the box")[/code]
# See [code]res://globals/dialogue_box_manager.gd[/code] for list of the signals.
extends Node

# The state of the dialogue box. If [code]true[/code], the box is typing its text.
var is_typing

# The standard dialogue box signal. 
signal type(text)

# Interupt the typing animation and closes the dialogue box immediately. Doesn't take any parameter.
signal done_typing()

# This signal doesn't seem to be used correctly.
signal choice_made(choice)

# Use this signal when interacting with a pickable item.
signal pick_up(item)

# Use this signal to indicate that you are adding the item into your inventory.
signal add_item(item)

# Maybe we should delete this???
signal lvl1(text)
signal lvl3(text)

# Use this signal to show dialogue box when certain item is hovered with the mouse.
signal hover_type(text)

