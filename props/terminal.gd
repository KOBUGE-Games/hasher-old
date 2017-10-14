tool
extends Area2D

export(int, "Red", "Neutral", "Green") var color = 0 setget set_color, get_color

func _ready():
	set_color(color)

func set_color(value):
	color = value
	if is_inside_tree():
		$decoration.frame = color

func get_color(): return color
