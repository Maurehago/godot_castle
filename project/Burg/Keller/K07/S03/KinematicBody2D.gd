extends KinematicBody2D

var dreh_geschw = 1
var schritt_geschw = 100
var drehung:float = 0

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var schritt:float = 0 # muss nach jedem durchlauf = 0 sein
	if Input.is_action_pressed("ui_up"):
		schritt = -schritt_geschw * delta
	if Input.is_action_pressed("ui_down"):
		schritt = schritt_geschw * delta
	if Input.is_action_pressed("ui_right"):
		drehung += dreh_geschw * delta
	if Input.is_action_pressed("ui_left"):
		drehung += -dreh_geschw * delta
	var vec = Vector2(0,schritt).rotated(drehung)
	move_and_collide(vec)
	# angabe in bogenmaß 2 * pi = 360°
	rotation = drehung
	