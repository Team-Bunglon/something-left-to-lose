extends Light2D
onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_one_shot(true)

func _on_timer_timeout():
	self.visible = false

func dimming():
	timer.start()
