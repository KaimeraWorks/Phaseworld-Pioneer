extends CanvasLayer

# Runtime Vars
var light_energy_meter_value_tween: Tween = null
var light_energy_meter_max_tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_energy_changed(new_light_energy: int) -> void:
	if light_energy_meter_value_tween != null:
		light_energy_meter_value_tween.kill()
	light_energy_meter_value_tween = create_tween()
	light_energy_meter_value_tween.tween_property($LightEnergyMeter, "value", new_light_energy, 1)


func _on_light_energy_max_changed(new_light_energy_max):
	if light_energy_meter_max_tween != null:
		light_energy_meter_max_tween.kill()
	light_energy_meter_max_tween = create_tween()
	light_energy_meter_max_tween.tween_property($LightEnergyMeter, "max_value", new_light_energy_max, 1)
