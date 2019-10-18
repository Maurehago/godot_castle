extends Node2D

var farbe = Color8(255,255,0,255)

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	if $KinematicBody2D.treffer:
		# update() veranlasst die Funktion
		# _draw() nochmals abzuarbeiten
		update()

func _draw():
	draw_circle($KinematicBody2D.koordinate,10,farbe)