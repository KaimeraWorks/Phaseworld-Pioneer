extends StatusEffectType

func application_effect(target: Node) -> void:
	target.get_node("LightEnergyTimer").stop()

# If Light Energy ends up being an actively usable resource, add periodic top-up
