extends CharacterBody3D
var tx = 1000.0
var ty = 2000.0
var tz = 3000.0
var noise = FastNoiseLite.new()
var rng = RandomNumberGenerator.new()
var seperationRay : CollisionShape3D
func _ready() -> void:
	tx *= rng.randf()
	ty *= rng.randf()
	tz *= rng.randf()
	seperationRay = $CollisionShape3D
func _physics_process(delta: float):
	self.global_position = Vector3(
		remap(noise.get_noise_1d(tx), -1, 1, -16, 16), 
		self.global_position.y,
		remap(noise.get_noise_1d(ty), -1, 1, -16, 16)
		)
	seperationRay.shape.length = remap(
		noise.get_noise_1d(tz), -1, 1, 0.1, 8
		)
	tx += delta*6
	ty += delta*6
	tz += delta*6
	velocity.y = -4
	move_and_slide()
