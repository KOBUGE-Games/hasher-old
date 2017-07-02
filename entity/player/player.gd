extends "res://entity/entity.gd"

func _ready():
	pass

func is_input_pressed(input): # virtual
	return Input.is_action_pressed(input)
