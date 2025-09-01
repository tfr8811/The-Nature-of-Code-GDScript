extends RigidBody2D

const SPEED = 2000.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = input_dir.normalized()
	if direction:
		apply_force(direction * SPEED)
	else:
		return
		apply_force(-linear_velocity)
