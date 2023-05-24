extends TileMap

#Signals
signal light_energy_changed(new_light_energy: int)
signal light_energy_max_changed(new_light_energy_max: int)

# Runtime Vars
var light_energy: int = 0:
	set(new_light_energy):
		light_energy = clampi(new_light_energy, 0, light_energy_max)
		light_energy_changed.emit(light_energy)

var light_energy_max: int = 100:
	set(new_light_energy_max):
		light_energy_max = new_light_energy_max
		light_energy_max_changed.emit(light_energy_max)

var light_energy_burn_rate: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Intranode
	light_energy = light_energy_max
	# Intrascene
	$LightEnergyTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_energy_timer_timeout():
	light_energy -= light_energy_burn_rate
