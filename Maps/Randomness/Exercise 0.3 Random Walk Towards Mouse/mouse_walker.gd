extends Node2D
var rng = RandomNumberGenerator.new()
func _physics_process(delta: float):
	if floor(rng.randf()*2):
		var choice = floor(rng.randf()*4)
		if (choice == 0):
			self.translate(Vector2(delta*400,0))
		elif (choice == 1):
			self.translate(Vector2(-delta*400,0))
		elif (choice == 2):
			self.translate(Vector2(0,delta*400))
		else:
			self.translate(Vector2(0,-delta*400))
	else:
		var mouseDir = get_viewport().get_mouse_position()-self.global_position
		mouseDir = mouseDir.normalized()
		print(mouseDir)
		self.translate(Vector2(delta*400*mouseDir.x,delta*400*mouseDir.y))
func _draw():
	draw_circle(Vector2(0,0), 4, Color(255,255,255))
