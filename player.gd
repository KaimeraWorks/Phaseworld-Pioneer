extends CharacterBody2D

signal moved(player_position)

@export var walk_speed = 500
@export var friction = 50

var movement_locked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	moved.emit(position)

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

func _on_triggered_dash(angle_to_cursor, magnitude):
	movement_locked = true
	velocity = (get_global_mouse_position() - position).normalized().rotated(angle_to_cursor) * magnitude
