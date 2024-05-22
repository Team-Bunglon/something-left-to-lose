extends Node2D

export (PackedScene) var obstacle
var timer

func _ready():
	repeat()

func spawn():
	var spawned = obstacle.instance()
	get_parent().call_deferred("add_child", spawned)

	var spawn_pos = global_position
	spawn_pos.x = spawn_pos.x

	spawned.global_position = spawn_pos

func repeat():
	timer = rand_range(1.0, 10.0)
	spawn()
	yield(get_tree().create_timer(timer), "timeout")
	repeat()
