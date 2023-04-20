extends Node

@export var light_mana_burn_rate: float = 1.0

var light_mana_max: int = 100
var light_mana: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$LightManaTimer.wait_time = light_mana_burn_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game() -> void:
	light_mana = light_mana_max
	$LightManaTimer.start()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_light_mana_timer_timeout():
	light_mana -= 1
