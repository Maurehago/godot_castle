extends Sprite

var geschw = 200

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var x = 0
	if Input.is_action_pressed("ui_right"):
		x = geschw * delta
	if Input.is_action_pressed("ui_left"):
		x = -geschw * delta
	position.x += x
