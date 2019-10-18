extends Node2D

var zeit_alt = 0
var zeit_neu = 0
var zeit_div = 0

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_Area2D_body_exited(body):
	zeit_neu = OS.get_unix_time()
	if zeit_alt != 0:
		zeit_div = zeit_neu - zeit_alt
	zeit_alt = zeit_neu
	$Label.text = str(zeit_div)
