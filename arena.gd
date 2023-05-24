extends "res://hex_tile_map_base.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$StatusEffectHandler.apply_effect("res://hearthlight.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
