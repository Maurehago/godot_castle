extends RigidBody2D
var reset = false

func _ready():
	# Mauszeiger verbergen
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_Area2D_body_entered(_body):
	# diese funktion wird aufgerufen wennn
	#der Phsikkörper den Area berührt
	reset = true

func _integrate_forces(state):
	# nur innerhalb dieser Funktion darf die Position geändert werden
    if reset:
        state.transform = Transform2D(0, Vector2(610, -60))
        state.linear_velocity = Vector2(0,0)
        reset = false