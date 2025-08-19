extends Node2D
var rng = RandomNumberGenerator.new()
@export var leftBias : bool = false
@export var upBias : bool = false
@export var rightBias : bool = false
@export var downBias : bool = false
func _physics_process(delta: float):
	var hChoice = rng.randf()*2
	var vChoice = rng.randf()*2
	if (leftBias):
		hChoice = (hChoice + 0.9) / 2
	if (rightBias):
		hChoice = (hChoice + 1.1) / 2
	if (upBias):
		vChoice = (vChoice + 0.9) / 2
	if (downBias):
		vChoice = (vChoice + 1.1) / 2
	if (floor(hChoice)):
		self.translate(Vector2(delta*400,0))
	else:
		self.translate(Vector2(-delta*400,0))
	if (floor(vChoice)):
		self.translate(Vector2(0,delta*400))
	else:
		self.translate(Vector2(0,-delta*400))
func _draw():
	draw_circle(Vector2(0,0), 4, Color(255,255,255))
