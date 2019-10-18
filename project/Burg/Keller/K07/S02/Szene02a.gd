extends Node2D

var Grad : float
var Bogenmass : float

func _ready():
	pass # Replace with function body.

func _process(delta):
	Grad += 0.7
	if Grad > 360:
		Grad = 0
	if Grad > 180:
		$Sprite1.z_index = 1
		$Sprite2.z_index = 0
	else:
		$Sprite1.z_index = 0
		$Sprite2.z_index = 1
	Bogenmass = deg2rad(Grad)
	$Sprite1.position.x = cos(Bogenmass) * 40 + 200
	$Sprite2.position.x = cos(Bogenmass + PI) * 40 + 200