extends Sprite

var a = 0

func _process(delta):
	a += delta / 2
	if a > PI*2:
		a = 0
	position.y += sin(a) * 2
