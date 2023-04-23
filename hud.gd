extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_mana_changed(new_light_mana) -> void:
	$LightManaMeter.value = new_light_mana

func change_light_mana_max(new_light_mana_max) -> void:
	$LightManaMeter.max_value = new_light_mana_max
