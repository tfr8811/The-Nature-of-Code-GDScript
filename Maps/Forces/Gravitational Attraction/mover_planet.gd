class_name MoverPlanet extends StaticBody2D

var mass = 1
var velocity = Vector2()
var acceleration = Vector2()
func apply_force(force: Vector2):
	acceleration = force/mass
func _physics_process(delta: float) -> void:
	velocity += acceleration * delta
	global_position += velocity * delta
	acceleration *= 0
