extends Node2D

var feld = []

var ball = load("res://Burg/Keller/K07/S11/Ball.tscn")

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var x : int = 0
	for a in range(3):
		x += 500
		feld.append(ball.instance())
		feld[a].position.x = x
		feld[a].position.y = -100
		add_child(feld[a])

func _process(delta):
	$KinematicBody2D.position.x += 100 * delta

# die folgenden Funktionen werden durch Signale ausgelöst
func _on_VisibilityNotifier2D_viewport_entered(viewport):
	# Das Angehänte Node VisibilityNotifier2D überwacht mit
	# seinem Rechteck ob dieses innerhalb des Viewport liegt
	$Label.text = "Godot meldet: er betritt den Sichtbereich"

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	$KinematicBody2D.position.x = -500
	$Label.text = "Godot meldet: er verlässt den Sichtbereich"

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	$Label.text = "Bereich meldet: Godot in Form von " + body.name + " betritt das Rechteck"

func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	$Label.text = "Bereich meldet: Godot hat das Rechteck verlassen"

func _on_Timer_timeout():
	pass