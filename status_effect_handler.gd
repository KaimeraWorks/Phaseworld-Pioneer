class_name StatusEffectHandler extends Node

var status_effects: Array[StatusEffect] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_effect(effect_name: String):
	var new_effect: StatusEffect = load(effect_name)
	new_effect.target = get_parent()
	status_effects.append(new_effect)
	new_effect.activation_effect()
