extends HSlider

export var bus_name: String

var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)

func _on_Volume_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index, value)
	
	if value == -30:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

