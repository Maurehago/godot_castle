extends PathFollow2D

func _ready():
	rotate = true
	loop = true
	set_process(true)

func _process(delta):
	# Path2d beschreibt den Weg
	# PathFollow2D ist ein Punkt auf diesem Weg
	# offset ist die zurückgelegte Strecke in Pixel
	offset += 50*delta

