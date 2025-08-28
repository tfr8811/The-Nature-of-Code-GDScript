extends Node2D
var location # position would be the position of this screen, not the ball
var velocity
var acceleration
var tx = 0.0
var ty = 10000.0
@export var noise = FastNoiseLite.new()
var speed = 0.5
var topSpeed = 5
func _ready() -> void:
	location = Vector2(200, 200)
	velocity = Vector2(0, 0)
	acceleration = Vector2(0, 0)
func _physics_process(delta: float) -> void:
	acceleration = Vector2(
		noise.get_noise_1d(tx) * speed, 
		noise.get_noise_1d(ty) * speed
	)
	velocity += acceleration
	velocity = limit(velocity, topSpeed)
	location += velocity
	tx += delta*12
	ty += delta*12
	check_edges()
	queue_redraw()
func limit(vect: Vector2, max: float) -> Vector2:
	if (vect.length() > max):
		return vect.normalized() * max
	return vect
func check_edges():
	if location.x > 1152:
		location.x = 0
	elif location.x < 0:
		location.x = 1152
	if location.y > 640:
		location.y = 0
	elif location.y < 0:
		location.y = 640

func _draw() -> void:
	draw_circle(location, 50, Color(255,255,255))
