extends Node2D
var tx = 0.0
var ty = 10000.0
var noise = FastNoiseLite.new()
func _physics_process(delta: float):
	self.global_position = Vector2(remap(noise.get_noise_1d(tx), -1, 1, 0, 1152), remap(noise.get_noise_1d(ty), -1, 1, 0, 648))
	tx += delta*12
	ty += delta*12
func _draw():
	draw_circle(Vector2(0,0), 50, Color(0,255,0))
	draw_circle(Vector2(0,0), 40, Color(255,255,255))
