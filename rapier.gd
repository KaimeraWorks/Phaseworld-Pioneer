extends "res://weapon.gd"

func init_stats():
	weapon_type = "rapier"
	trigger = "melee"
	initial_charge = 50
	charge_speed = 100
	quick_action_power = 1000
	charge_action_power_multiplier = 20
	quick_action_cooldown = 0.5

func quick_action():
	triggered_dash.emit(PI, quick_action_power)

func charge_action():
	triggered_dash.emit(0, charge_action_power_multiplier * built_charge)
