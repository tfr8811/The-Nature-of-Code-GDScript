extends CharacterBody3D
var acceleration
var speed = 0.1
func _ready() -> void:
	acceleration = Vector3(0.1, 0, 0)
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		rotate(Vector3.UP, 0.05)
	if Input.is_action_pressed("Right"):
		rotate(Vector3.UP, -0.05)
	if Input.is_action_pressed("Jump"):
		acceleration = -velocity.normalized() * speed
	else:
		acceleration = -transform.basis.z * speed
	velocity = Vector3(clampf(velocity.x, -5, 5), velocity.y, clampf(velocity.z, -5, 5))
	velocity += acceleration
	move_and_slide()
