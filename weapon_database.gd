extends Node

var weapon = {
	"rapier": {
		"scene": preload("res://rapier.tscn"),
		"base_class": "Fencer",
		"subclasses": {
			"dagger": "Duelist",
			"orb": "Red Mage",
			"pistol": "Swashbuckler"
		}
	},
	"dagger": {
		"scene": preload("res://dagger.tscn"),
		"base_class": "Rogue",
		"subclasses": {
			"dagger": "Assassin"
		}
	},
	"orb": {
		"scene": null,
		"base_class": "Seer"
	},
	"pistol": {
		"scene": null,
		"base_class": null
	}
}
