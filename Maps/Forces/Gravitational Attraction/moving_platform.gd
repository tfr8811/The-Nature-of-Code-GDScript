extends AnimatableBody2D

@export
var speed:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.constant_linear_velocity = Vector2(speed, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	move_and_collide(constant_linear_velocity * _delta)
	check_edges()
func check_edges():
	if position.x > 1452:
		position.x = -300
	elif position.x < -300:
		position.x = 1452
