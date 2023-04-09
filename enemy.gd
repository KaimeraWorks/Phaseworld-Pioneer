extends CharacterBody2D

@export var walk_speed = 100
@export var friction = 50
@export var health = 1

func _physics_process(delta):
	if $"../../Player": # Make this more flexible
		velocity = ($"../../Player".position - position).normalized() * walk_speed
	else:
		velocity.move_toward(Vector2.ZERO, friction)
	if move_and_slide():
		var collider: Object = get_last_slide_collision().get_collider()
		if collider.is_in_group("player"):
			collider.take_damage(1)
		

func take_damage(damage: int): # Give this guy some immunity so it doesn't take damage every frame, probably stun too
	health -= damage
	if health < 1:
		queue_free()
