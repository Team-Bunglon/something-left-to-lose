extends Light2D

onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	self.visible = false

func dimming():
	timer.start()
