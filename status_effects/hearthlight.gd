extends StatusEffectType

func application_effect(target: Node) -> void:
	assert(target.has_node("LightEnergyTimer"), "Attempting to apply Hearthlight to something without a light energy timer.")
	target.get_node("LightEnergyTimer").stop()

# If Light Energy ends up being an actively usable resource, add periodic top-up
