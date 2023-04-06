extends Node

signal triggered_dash(angle_to_cursor, magnitude)

const CHARGE_START_DELAY = 0.33
const CHARGE_MAX = 100

@export var weapon_type: String = "weapon"
@export var trigger: String = "melee"
@export var initial_charge: int = 0
@export var charge_speed: int = 0
@export var quick_action_power = 0
@export var charge_action_power_multiplier = 0
@export var quick_action_cooldown = 0

var charging: bool = false
var built_charge: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	init_stats()
	$"Charge Start Timer".set_wait_time(CHARGE_START_DELAY)
	$"Quick Action Cooldown Timer".set_wait_time(quick_action_cooldown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(trigger):
		$"Charge Start Timer".start()
	elif Input.is_action_just_released(trigger):
		if not $"Charge Start Timer".is_stopped():
			$"Charge Start Timer".stop()
			if $"Quick Action Cooldown Timer".is_stopped():
				quick_action()
				$"Quick Action Cooldown Timer".start()
		else:
			charge_action()
			charging = false
			built_charge = 0
	
	if charging:
		built_charge += charge_speed * delta
		if built_charge > CHARGE_MAX:
			built_charge = CHARGE_MAX
			charging = false

func init_stats():
	pass

func quick_action():
	pass

func charge_action():
	pass

func _on_charge_start_timer_timeout():
	charging = true
	built_charge = initial_charge
