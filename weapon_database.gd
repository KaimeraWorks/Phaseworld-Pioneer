extends Node

var weapon = {
	"rapier": {
		"base_class": "Fencer",
		"subclasses": {
			"dagger": "Duelist",
			"orb": "Red Mage",
			"pistol": "Swashbuckler",
			"rilfe": "Musketeer"
		},
		"quick_action_main_hand": {
			"action": [
				[
					{
						"type": "lunge",
						"power": 1000,
						"distance": 1000,
						"angle": PI,
						"scene": preload("res://attacks/rapier_lunge.tscn")
					}
				]
			],
			"cooldown": 0.5
		},
		"charge_action_main_hand": {
			"action": [
				[ # Make parry the first step, followed by a dash attack
					{
						"type": "lunge",
						"power": 20,
						"distance": 20,
						"angle": 0,
						"scene": preload("res://attacks/rapier_lunge.tscn")
					}
				]
			],
			"initial_charge": 50,
			"charge_rate": 100
		}
	},
	"dagger": {
		"base_class": "Rogue",
		"subclasses": {
			"dagger": "Assassin"
		},
		"quick_action_main_hand": null,
		"charge_action_main_hand": null,
		"quick_action_off_hand": null,
		"charge_action_off_hand": null
	},
	"orb": {
		"base_class": "Seer",
		"quick_action_main_hand": null,
		"charge_action_main_hand": null,
		"quick_action_off_hand": null,
		"charge_action_off_hand": null
	},
	"pistol": {
		"base_class": null,
		"quick_action_main_hand": null,
		"charge_action_main_hand": null,
		"quick_action_off_hand": null,
		"charge_action_off_hand": null
	},
	"rifle": {
		"base_class": "Gunner",
		"quick_action_main_hand": null,
		"charge_action_main_hand": null,
		"quick_action_off_hand": null,
		"charge_action_off_hand": null
	}
}
