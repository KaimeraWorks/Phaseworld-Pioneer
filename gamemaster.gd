extends Node

signal light_mana_changed(new_light_mana: int)

@export var light_mana_burn_rate: float = 1.0

var light_mana_max: int = 100
var light_mana: int = 0:
	set(new_light_mana):
		light_mana = new_light_mana
		light_mana_changed.emit(light_mana)

# Called when the node enters the scene tree for the first time.
func _ready():
	$LightManaTimer.wait_time = light_mana_burn_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	light_mana = light_mana_max
	$LightManaTimer.start()

func _on_light_mana_timer_timeout() -> void:
	light_mana -= 1
