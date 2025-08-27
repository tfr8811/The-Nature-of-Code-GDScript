extends Node2D
var location # position would be the position of this screen, not the ball
var velocity
func _ready() -> void:
	location = Vector2(200, 200)
	velocity = Vector2(5, 4)

func _physics_process(delta: float) -> void:
	location += velocity
	check_edges()
	queue_redraw()

func check_edges():
	if location.x > 1152 || location.x < 0:
		velocity.x *= -1
	if location.y > 640 || location.y < 0:
		velocity.y *= -1

func _draw() -> void:
	draw_circle(location, 50, Color(255,255,255))
