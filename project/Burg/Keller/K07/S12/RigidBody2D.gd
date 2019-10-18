extends RigidBody2D

var reset = false
var richtungvec = Vector2(0,-10)

func _integrate_forces(state):
	if Input.is_action_pressed('ui_up'):
		apply_central_impulse(richtungvec.rotated(rotation))
	elif Input.is_action_pressed('ui_down'):
		apply_central_impulse(richtungvec.rotated(rotation + PI))
	if Input.is_action_pressed('ui_left'):
		apply_torque_impulse(-50)
	elif Input.is_action_pressed('ui_right'):
		apply_torque_impulse(50)
	if reset:
		state.transform = Transform2D(0.0, Vector2(200, 580))
		state.linear_velocity = Vector2()
		reset = false

func _on_VisibilityNotifier2D_screen_exited():
	reset = true
