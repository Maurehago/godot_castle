extends Navigation2D

const geschw = 200.0
var weg = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	if weg.size() > 1:
		var schrittweite = delta * geschw
		while schrittweite > 0 and weg.size() > 1:
			var von = weg[weg.size() - 1]
			var nach = weg[weg.size() - 2]
			var entfernung = von.distance_to(nach)
			if entfernung <= schrittweite:
				weg.remove(weg.size() - 1)
				schrittweite -= entfernung
			else:
				weg[weg.size() - 1] = von.linear_interpolate(nach, schrittweite / entfernung)
				schrittweite = 0
		var atpos = weg[weg.size() - 1]
		$Sprite.position = atpos
	else:
		set_process(false)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		weg = get_simple_path($Sprite.position, event.position, false)
		weg.invert()
		set_process(true)
