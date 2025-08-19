extends Node2D
var randomCounts = []
var total = 20
var rng = RandomNumberGenerator.new()
func _ready():
	for i in range(total):
		randomCounts.push_back(0)
func _physics_process(delta: float) -> void:
	queue_redraw()
	
func _draw():
	var index = floor(rng.randf()*randomCounts.size())
	randomCounts[index] += 1
	var w = 1152 / randomCounts.size();
	for x in range(randomCounts.size()):
		draw_rect(Rect2(x*w,648-randomCounts[x], w-1, randomCounts[x]), Color.GRAY)
