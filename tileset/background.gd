extends ParallaxBackground

func _ready():
	get_viewport().connect("size_changed", self, "_size_changed")
	_size_changed()

func _size_changed():
	$static_background/texture_rect.rect_size = get_viewport().size
	$static_background.motion_mirroring = get_viewport().size
