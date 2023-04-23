extends Node

signal light_mana_changed(new_light_mana: int)

@export var light_mana_burn_rate: float = 0.1

var light_mana_max: int = 100
var light_mana: int = 0:
	set(new_light_mana):
		light_mana = new_light_mana
		light_mana_changed.emit(light_mana)

# Called when the node enters the scene tree for the first time.
func _ready():
	light_mana = light_mana_max
	$HUD.change_light_mana_max(light_mana_max)
	$LightManaTimer.wait_time = light_mana_burn_rate
	$LightManaTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_mana_timer_timeout():
	light_mana -= 1
