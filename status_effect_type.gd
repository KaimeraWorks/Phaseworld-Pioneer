class_name StatusEffectType extends Resource

# Settings
@export var name: String = ""
@export var is_field_effect: bool = false
@export var is_unremovable: bool = false
@export var duration: float = 0
@export var period: float = 0

# Effects
func application_effect(target: Node) -> void:
	pass

func periodic_effect(target: Node) -> void:
	pass

func expiration_effect(target: Node) -> void:
	pass
