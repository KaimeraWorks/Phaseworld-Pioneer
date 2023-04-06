extends CharacterBody2D

@export var walk_speed = 250
@export var friction = 50

func _physics_process(delta):
	if $"../../Player":
		velocity = ($"../../Player".position - position).normalized() * walk_speed
	else:
		velocity.move_toward(Vector2.ZERO, friction)
	move_and_slide()
