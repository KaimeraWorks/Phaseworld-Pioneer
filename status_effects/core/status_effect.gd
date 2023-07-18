extends Node

var type: StatusEffectType = null

func activate(new_type: StatusEffectType):
	assert(get_parent() != null, "Attempting to activate a status effect that isn't attached to a target.")
	assert(get_parent().name == "StatusEffectHandler", "Attempting to activate an improperly attached status effect.")
	assert(type == null, "Attempting to activate an already activated status effect.")
	assert(new_type != null, "Attempting to activate a status effect with invalid type.")
	type = new_type
	type.application_effect(get_parent().get_parent())
	if type.duration > 0:
		$ExpirationEffectTimer.start(type.duration)
	if type.period > 0:
		$PeriodicEffectTimer.start(type.period)

func _on_expiration_effect_timer_timeout(): # Make the icon blink when time is running low, too
	type.expiration_effect(get_parent().get_parent())
	queue_free()

func _on_periodic_effect_timer_timeout():
	type.periodic_effect(get_parent().get_parent())
