extends Node

@export var status_effect_scene: PackedScene

func apply_effect(effect_type: StatusEffectType):
	if get_parent() is HexTileMapBase:
		assert(effect_type.is_field_effect, "Attempting to apply a field effect to something other than a tile map.")
	else:
		assert(not effect_type.is_field_effect, "Attempting to apply a regular effect to a tile map.")
	var new_status_effect = status_effect_scene.instantiate()
	add_child(new_status_effect)
	new_status_effect.activate(effect_type)
