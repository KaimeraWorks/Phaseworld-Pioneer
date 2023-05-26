extends Node

var type: StatusEffectType = null
var target: Node = null

func activate(new_type: StatusEffectType, new_target: Node):
	assert(type == null and target == null, "Attempting to activate an already activated status effect.")
	assert(new_type != null and new_target != null, "Attempting to activate a status effect with invalid parameters.")
	type = new_type
	target = new_target
	type.application_effect(target)
	if type.duration > 0:
		$ExpirationEffectTimer.start(type.duration)
	if type.period > 0:
		$PeriodicEffectTimer.start(type.period)

func _on_expiration_effect_timer_timeout(): # Make the icon blink when time is running low, too
	type.expiration_effect(target)
	queue_free()

func _on_periodic_effect_timer_timeout():
	type.periodic_effect(target)
