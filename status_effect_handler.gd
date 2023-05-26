extends Node

var status_effect_scene = preload("res://status_effect.tscn")

func apply_effect(effect_type: StatusEffectType):
	if effect_type.is_field_effect:
		assert(get_parent() is HexTileMapBase, "Attempting to apply a field effect to something other than a tile map.")
	else:
		pass # Add an assert after creating a Node with a StatusEffectHandler for mobs to inherit
	var new_status_effect = status_effect_scene.instantiate()
	add_child(new_status_effect)
	new_status_effect.activate(effect_type, get_parent())
