extends Node

#Signals
signal light_mana_changed(new_light_mana: int, current_light_mana_max: int)

# Settings
@export var light_mana_max: int = 100
@export var light_mana_burn_rate: int = 1

# Runtime Vars
var light_mana: int:
	set(new_light_mana):
		light_mana = clampi(new_light_mana, 0, light_mana_max)
		light_mana_changed.emit(light_mana, light_mana_max)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Intranode
	light_mana = light_mana_max
	# Intrascene
	$LightManaTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_mana_timer_timeout() -> void:
	light_mana -= light_mana_burn_rate
