extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Gamemaster.light_mana_changed.connect(_on_light_mana_changed)
	$LightManaMeter.max_value = Gamemaster.light_mana_max
	$LightManaMeter.value = Gamemaster.light_mana

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_light_mana_changed(new_light_mana) -> void:
	$LightManaMeter.value = new_light_mana
