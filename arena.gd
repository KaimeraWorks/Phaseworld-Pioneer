extends HexTileMapBase

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$StatusEffectHandler.apply_effect(preload("res://hearthlight.tres"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
