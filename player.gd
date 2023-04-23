extends CharacterBody2D

# Signals
signal moved(player_position: Vector2)

# Constants
#	Actions
enum Trigger {NONE, MAIN_HAND, OFF_HAND}

# Settings
#	Stats
@export var max_health: int = 1
#	Movement
@export var walk_speed: int = 500
@export var base_friction: int = 50
#	Actions
@export var quick_taunt_cooldown: float = 0.5
#	Charging
@export var charge_start_delay: float = 0.33
@export var charge_max: int = 100
@export var taunt_charge_rate: int = 100
@export var taunt_initial_charge: int = 0

# Runtime Vars
#	Stats
var health: int = 0
#	Movement
var movement_locked: bool = false
var effect_velocity: Vector2 = Vector2.ZERO
#	Equipment
var main_hand_weapon: String = ""
var off_hand_weapon: String = ""
var current_class: String = ""
#	Actions
var active_trigger: Trigger = Trigger.NONE
var current_attack = null
var movement_locking_attack: bool = false
#	Charging
var charging: bool = false
var built_charge: int = 0

# Engine
# Called when the node enters the scene tree for the first time.
func _ready():
	# Intranode
	health = max_health
	# Intrascene
	$"Charge Start Timer".set_wait_time(charge_start_delay)
	# Temporary
	equip_weapon("rapier", true)
	equip_weapon("orb", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_trigger == Trigger.NONE:
		if Input.is_action_just_pressed("main_hand_trigger"):
			active_trigger = Trigger.MAIN_HAND
			$"Charge Start Timer".start()
		elif Input.is_action_just_pressed("off_hand_trigger"): # Main hand takes precedence when simultaneous
			active_trigger = Trigger.OFF_HAND
			$"Charge Start Timer".start()
	else:
		if Input.is_action_just_released("main_hand_trigger" if active_trigger == Trigger.MAIN_HAND else "off_hand_trigger"):
			if not $"Charge Start Timer".is_stopped():
				$"Charge Start Timer".stop()
				if $"Quick Action Cooldown Timer".is_stopped():
					quick_action()
			else:
				charge_action()
			active_trigger = Trigger.NONE
		elif charging:
			var action_info = get_active_weapon_action_info(true)
			var charge_rate: int = action_info["charge_rate"] if action_info != null else taunt_charge_rate
			built_charge += charge_rate * delta
			if built_charge > charge_max:
				built_charge = charge_max
				charging = false

func _physics_process(delta):
	var walking: bool = false
	if not effect_velocity.is_zero_approx():
		movement_locked = true
		velocity = effect_velocity
		effect_velocity = Vector2.ZERO
	if not movement_locked:
		var direction: Vector2 = Vector2.ZERO
		direction.y = Input.get_axis("move_north", "move_south")
		direction.x = Input.get_axis("move_west", "move_east")
		if not direction.is_zero_approx():
			walking = true
			velocity = direction.normalized() * walk_speed
	if not velocity.is_zero_approx():
		moved.emit(position)
		if not walking:
			velocity = velocity.move_toward(Vector2.ZERO, base_friction)
		move_and_slide()
	else:
		movement_locked = false
		if movement_locking_attack:
			current_attack.queue_free()
			current_attack = null
			movement_locking_attack = false

# Stats
func take_damage(damage: int):
	health -= damage
	if health < 1:
		get_tree().change_scene_to_file("res://main_menu.tscn")

# Equipment
func can_equip_weapon(weapon_name: String, main_hand: bool) -> bool:
	if main_hand:
		if off_hand_weapon == "":
			return true
		return true if WeaponDatabase.weapon[weapon_name]["subclasses"].has(off_hand_weapon) else false
	else:
		if main_hand_weapon == "":
			return false
		return true if WeaponDatabase.weapon[main_hand_weapon]["subclasses"].has(weapon_name) else false

func equip_weapon(weapon_name: String, main_hand: bool) -> void:
	if main_hand:
		main_hand_weapon = weapon_name
		if off_hand_weapon == "":
			current_class = WeaponDatabase.weapon[weapon_name]["base_class"]
		else:
			current_class = WeaponDatabase.weapon[weapon_name]["subclasses"][off_hand_weapon]
	else:
		off_hand_weapon = weapon_name
		current_class = WeaponDatabase.weapon[main_hand_weapon]["subclasses"][weapon_name]
	$Label.text = current_class # Replace with more advanced UI

# Actions
func quick_action() -> void:
	var action_info = get_active_weapon_action_info(false)
	if action_info == null:
		pass # Do a quick taunt
		$"Quick Action Cooldown Timer".wait_time = quick_taunt_cooldown
	else:
		perform_action(action_info["action"], 1)
		$"Quick Action Cooldown Timer".wait_time = action_info["cooldown"]
	$"Quick Action Cooldown Timer".start()

func charge_action() -> void:
	var action_info = get_active_weapon_action_info(true)
	if action_info == null:
		pass # Do a charged taunt
	else:
		perform_action(action_info["action"], built_charge)
	charging = false
	built_charge = 0
	
func perform_action(action_sequence: Array, charge_multiplier: int) -> void:
	var current_action_set: Array = action_sequence[0]
	for action in current_action_set:
		match action["type"]:
			"attack":
				perform_attack(action["power"] * charge_multiplier, action["scene"])
			"dash":
				perform_dash(action["distance"] * charge_multiplier, action["angle"])
			"lunge":
				movement_locking_attack = true
				perform_attack(action["power"] * charge_multiplier, action["scene"])
				perform_dash(action["distance"]  * charge_multiplier, action["angle"])

func perform_attack(power: int, scene: PackedScene): # Change duration to type probably
	current_attack = scene.instantiate()
	current_attack.rotation = (get_global_mouse_position() - position).angle() + PI / 2 # Make sprites from left to right
	add_child(current_attack)
	current_attack.body_entered.connect(_on_current_attack_body_entered)

func perform_dash(distance: int, angle: float):
	effect_velocity = (get_global_mouse_position() - position).normalized().rotated(angle) * distance

# Signals
func _on_charge_start_timer_timeout() -> void:
	charging = true
	var action_info = get_active_weapon_action_info(true)
	built_charge = action_info["initial_charge"] if action_info != null else taunt_initial_charge

func _on_current_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(1)

# Helpers
func get_active_weapon_info():
	match active_trigger:
		Trigger.NONE:
			return null
		Trigger.MAIN_HAND:
			return WeaponDatabase.weapon[main_hand_weapon] if main_hand_weapon != "" else null
		Trigger.OFF_HAND:
			return WeaponDatabase.weapon[off_hand_weapon] if off_hand_weapon != "" else null

func get_active_weapon_action_info(charged: bool):
	var active_weapon_info = get_active_weapon_info()
	if active_weapon_info == null:
		return null
	var entry_prefix: String = "charge_action" if charged else "quick_action"
	var entry_suffix: String = "_main_hand" if active_trigger == Trigger.MAIN_HAND else "_off_hand"
	var entry: String = entry_prefix + entry_suffix
	return active_weapon_info[entry]
