extends Area2D

signal moved(player_position)

@export var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	moved.emit(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_north"):
		velocity.y -= 1
	if Input.is_action_pressed("move_east"):
		velocity.x += 1
	if Input.is_action_pressed("move_south"):
		velocity.y += 1
	if Input.is_action_pressed("move_west"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		moved.emit(position)
