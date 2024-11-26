extends Node

var is_typing

var second_encounter = {}

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

func mark_second_encounter(scene_path: String):
	second_encounter[scene_path] = true
	
func check_second_encounter(scene_path: String) -> bool:
	return second_encounter.get(scene_path, false)
	
func reset_scenes():
	second_encounter.clear()
