extends KinematicBody2D

var richtung = Vector2()
 
const boden_richtung = Vector2(0,-1)
const gravity = 10
const gschw = 200
const sprung = -500

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		richtung.x = gschw
	elif Input.is_action_pressed("ui_left"):
		richtung.x = -gschw
	else:
		richtung.x = 0
	if is_on_floor() and Input.is_action_pressed("ui_select"):
		richtung.y = sprung
	else:
		richtung.y += gravity
	move_and_slide(richtung, boden_richtung)