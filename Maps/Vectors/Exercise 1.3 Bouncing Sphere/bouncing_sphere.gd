extends MeshInstance3D
var velocity
func _ready() -> void:
	velocity = Vector3(0.05, 0.04, 0.06)
func _physics_process(delta: float) -> void:
	position += velocity
	check_edges()
func check_edges():
	if position.x > 8 || position.x < -8:
		velocity.x *= -1
	if position.y > 6 || position.y < 0:
		velocity.y *= -1
	if position.z > 5 || position.z < -5:
		velocity.z *= -1
