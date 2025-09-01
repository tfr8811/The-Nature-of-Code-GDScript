extends CharacterBody2D
var acceleration
var speed = 200
func _physics_process(delta: float) -> void:
	acceleration = (get_global_mouse_position()-global_position).normalized()
	velocity += acceleration * delta * speed
	move_and_slide()
