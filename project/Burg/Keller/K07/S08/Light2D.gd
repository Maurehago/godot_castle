extends Light2D

var a = 0

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	a += delta / 2
	if a > PI*2:
		a = 0
	position.x += sin(a) * 2
	rotation = cos(a) / 2
