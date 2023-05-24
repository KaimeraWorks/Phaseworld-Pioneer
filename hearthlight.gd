class_name Hearthlight extends StatusEffect

func activation_effect() -> void:
	target.get_node("LightEnergyTimer").stop()
