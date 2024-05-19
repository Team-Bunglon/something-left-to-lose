extends Node2D

var sandi_locker = ""
var rng = RandomNumberGenerator.new()
onready var kertas_sandi = $kertassandi

func _ready():
	sandi_locker = _generate_sandi()
	
	###
	# Ini masih perlu ganti instance tujuan harusnya
	kertas_sandi.set_sandi(sandi_locker)
	#$tembok2/vending_machine.set_sandi(sandi_locker)
	###

func _generate_sandi():
	var sandi = ""
	for i in range(0,5):
		var char_type_decision = rng.randi()%2
		var alphabet = rng.randi_range(48,57)
		if char_type_decision==1:
			alphabet = rng.randi_range(65,90)
		sandi+=char(alphabet)
	return sandi
