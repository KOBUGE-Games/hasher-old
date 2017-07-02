extends RigidBody2D

export var can_move = true
export var can_jump = true
export var can_duck = true
export var jump_impulse = 100.0
export var max_movement_speed = 100.0
export var movement_acceleration = 100.0
export var moving_friction = 0.1
onready var standing_friction = get_friction()

func _ready():
	pass

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	var moving = false
	if is_input_pressed("jump") and $jump_ray.is_colliding():
		velocity.y = -jump_impulse
	if is_input_pressed("left"):
		moving = true
		velocity.x += -movement_acceleration * state.get_step()
	if is_input_pressed("right"):
		moving = true
		velocity.x += movement_acceleration * state.get_step()
	
	friction = moving_friction if moving else standing_friction
	velocity.x = clamp(velocity.x, -max_movement_speed, max_movement_speed)
	state.set_linear_velocity(velocity)

func is_input_pressed(input): # virtual
	return false
