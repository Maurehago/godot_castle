extends RigidBody2D

var reset = false
var richtungvec = Vector2(0,-10)
var antrieb = 0

func _input(event):
	if event.is_action_pressed('move_forward'):
		richtungvec.rotated(rotation)
	elif event.is_action_pressed('move_backward'):
		richtungvec.rotated(rotation + PI)
	else:
		richtungvec = Vector2(0,0)
	if event.is_action_pressed('move_left'):
		antrieb = -50
		print("ss")
	elif event.is_action_pressed('move_right'):
		antrieb = 50
		print("ss")
	else:
		antrieb = 0


func _integrate_forces(state):
	apply_central_impulse(richtungvec)
	apply_torque_impulse(antrieb)
	if reset:
		state.transform = Transform2D(0.0, Vector2(200, 580))
		state.linear_velocity = Vector2()
		reset = false

func _on_VisibilityNotifier2D_screen_exited():
	reset = true
