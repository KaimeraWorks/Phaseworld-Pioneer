extends Node

var weapon = {
	"rapier": {
		"scene": preload("res://rapier.tscn"),
		"base_class": "Fencer",
		"subclasses": {
			"dagger": "Duelist"
		}
	},
	"dagger": {
		"scene": preload("res://dagger.tscn"),
		"base_class": "Knave"
	}
}
