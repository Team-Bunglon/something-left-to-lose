extends Node

var is_typing

signal type(text)
signal done_typing()
signal choice_made(choice)

# Pake signal ini kalo mau pas interact,bisa pick up bendanya 
signal pick_up(item)
signal add_item(item)

# signal buat cutscene level 3 biar gk perlu pause sama mencet spacebar
signal lvl1(text)
signal lvl3(text)

# signal buat movement guide
signal hover_dia(text)

