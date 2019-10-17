extends KinematicBody2D

var dreh_geschw = 1
var schritt_geschw = 100
var drehung:float = 0
var koordinate = Vector2()
var treffer = false
var farbe = Color8(0,255,0,255)

func _process(delta):
	var schritt:float = 0 # muss nach jedem durchlauf = 0 sein
	if Input.is_action_pressed("ui_up"):
		schritt = schritt_geschw * delta
	if Input.is_action_pressed("ui_down"):
		schritt = -schritt_geschw * delta
	if Input.is_action_pressed("ui_right"):
		drehung += dreh_geschw * delta
	if Input.is_action_pressed("ui_left"):
		drehung += -dreh_geschw * delta
	var vec = Vector2(0,schritt).rotated(drehung)
	move_and_collide(vec)
	# angabe in bogenmaß 2 * pi = 360°
	rotation = drehung
	if $RayCast2D.is_colliding():
		treffer = true
		koordinate = $RayCast2D.get_collision_point()
		$"../Label2".text = $RayCast2D.get_collider().name
	else:
		treffer = false
		$"../Label2".text = " "

func _draw():
	# diese funktion wird einmalig beim start aufgerufen
	# bezugnehmend von dem übergeordneten Node bewegen sich
	# die gezeichneten Ojekte mit.
	draw_line(Vector2(0,0),Vector2(0,300),farbe,2)