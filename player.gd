extends CharacterBody2D

signal moved(player_position)

@export var walk_speed = 500
@export var friction = 50

var movement_locked = false
var main_hand_weapon = null
var off_hand_weapon = null

# Called when the node enters the scene tree for the first time.
func _ready():
	moved.emit(position)
	equip_weapon("rapier", true) # Temporary

func _physics_process(delta):
	var walking = false
	if not movement_locked:
		var direction = Vector2.ZERO
		direction.y = Input.get_axis("move_north", "move_south")
		direction.x = Input.get_axis("move_west", "move_east")
		
		if direction:
			walking = true
			velocity = direction.normalized() * walk_speed
	
	if velocity:
		moved.emit(position)
		if not walking:
			velocity = velocity.move_toward(Vector2.ZERO, friction)
		move_and_slide()
	else:
		movement_locked = false

func equip_weapon(weapon_name, main_hand):
	var new_weapon = WeaponDatabase.weapon[weapon_name]["scene"].instantiate() # Will need different code for pickups
	if main_hand:
		main_hand_weapon = new_weapon # Add code for unequipping and swapping
	else:
		off_hand_weapon = new_weapon
	new_weapon.triggered_dash.connect(_on_triggered_dash) # Will need more generic ability signal names
	add_child(new_weapon)

func _on_triggered_dash(angle_to_cursor, magnitude):
	movement_locked = true
	velocity = (get_global_mouse_position() - position).normalized().rotated(angle_to_cursor) * magnitude
