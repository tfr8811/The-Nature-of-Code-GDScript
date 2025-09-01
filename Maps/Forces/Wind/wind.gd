extends Area2D
var speed = 500
func _physics_process(delta: float) -> void:
	if (has_overlapping_bodies()):
		for body in get_overlapping_bodies():
			if body is RigidBody2D:
				body.apply_force(Vector2.LEFT*speed)
