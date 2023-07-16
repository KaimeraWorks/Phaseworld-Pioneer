extends HexTileMapBase

@export var status_effect_hearthlight: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$StatusEffectHandler.apply_effect(status_effect_hearthlight)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
