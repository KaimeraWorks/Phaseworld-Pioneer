extends CanvasLayer

# Runtime Vars
var light_mana_meter_tween: Tween = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_mana_changed(new_light_mana: int, current_light_mana_max: int) -> void:
	var meter_ratio: int = new_light_mana * $LightManaMeter.max_value / current_light_mana_max
	if light_mana_meter_tween != null:
		light_mana_meter_tween.kill()
	light_mana_meter_tween = create_tween()
	light_mana_meter_tween.tween_property($LightManaMeter, "value", meter_ratio, 1)
