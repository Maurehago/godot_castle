extends RigidBody2D

var reset_state = false
var xx = 0
   
	
func _process(delta):
	if position.y > 500:
		reset_state = true

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, Vector2(xx, -100))
		state.linear_velocity = Vector2()
		reset_state = false