class_name StatusEffect extends Resource

# Settings
@export var is_field_effect: bool = false
@export var duration: float = 0
@export var frequency: float = 0

# Runtime Vars
var target: Node = null

# Effects
func activation_effect() -> void:
	pass

func continuous_effect() -> void:
	pass

func deactivation_effect() -> void:
	pass
