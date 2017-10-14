extends RigidBody2D

export var can_move = true
export var can_jump = true
export var can_duck = true
export var jump_impulse = 100.0
export var jump_secondary_impulse = 100.0
export var jump_secondary_time = 1.0
export var max_movement_speed = 100.0
export var movement_acceleration = 100.0
export var moving_friction = 0.1
export var stop_smoothing = 0.3
onready var standing_friction = get_friction()
var jump_time = INF

func _ready():
	pass

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	var moving = false
	if is_input_pressed("jump"):
		if $jump_ray.is_colliding():
			velocity.y = -jump_impulse
			jump_time = 0
		elif jump_time > jump_secondary_time and jump_time != INF:
			jump_time = INF
			velocity.y -= jump_secondary_impulse
		jump_time += state.get_step()
	if is_input_pressed("left"):
		moving = true
		velocity.x += -movement_acceleration * state.get_step()
	if is_input_pressed("right"):
		moving = true
		velocity.x += movement_acceleration * state.get_step()
	
	
	
	if moving:
		friction = moving_friction
	else:
		friction = standing_friction
		velocity.x = lerp(velocity.x, 0, state.get_step() * stop_smoothing)
	velocity.x = clamp(velocity.x, -max_movement_speed, max_movement_speed)
	state.set_linear_velocity(velocity)

func is_input_pressed(input): # virtual
	return false
