extends Node2D
# 2D noises for each color
var rNoise = 0.0
var gNoise = 1000.0
var bNoise = 2000.0
# time increment
var tz = 0.0
var noise = FastNoiseLite.new()
const cellSize = 10
const zoom = 10
# viewport reference
@export var subViewport : SubViewport
func _physics_process(delta: float) -> void:
	tz += delta*15
	queue_redraw()
func _draw():
	for i in range(subViewport.get_size().x/cellSize+1):
		for j in range(subViewport.get_size().y/cellSize+1):
			var redVal = remap(noise.get_noise_3d(rNoise+i*cellSize/zoom, rNoise+j*cellSize/zoom, tz), -1, 1, 0, 1)
			var greenVal = remap(noise.get_noise_3d(gNoise+i*cellSize/zoom, gNoise+j*cellSize/zoom, tz), -1, 1, 0, 1)
			var blueVal = remap(noise.get_noise_3d(bNoise+i*cellSize/zoom, bNoise+j*cellSize/zoom, tz), -1, 1, 0, 1)
			draw_rect(Rect2(Vector2(i*cellSize, j*cellSize), Vector2(cellSize, cellSize)), Color(redVal, blueVal, greenVal))
