extends Node2D
var rng = RandomNumberGenerator.new()
func _physics_process(delta: float):
	var choice = floor(rng.randf()*4)
	if (choice == 0):
		self.translate(Vector2(delta*400,0))
	elif (choice == 1):
		self.translate(Vector2(-delta*400,0))
	elif (choice == 2):
		self.translate(Vector2(0,delta*400))
	else:
		self.translate(Vector2(0,-delta*400))
func _draw():
	draw_circle(Vector2(0,0), 4, Color(255,255,255))
