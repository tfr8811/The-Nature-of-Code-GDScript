extends Node2D

var bodies: Array[MoverPlanet] = []
@export var planet: PackedScene
var rng = RandomNumberGenerator.new()
var G = 9.8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,10):
		bodies.push_back(planet.instantiate())
		bodies[i].global_position = Vector2(rng.randf()*1152, rng.randf()*648)
		bodies[i].mass = 10
		add_child(bodies[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for i in range(0, bodies.size()):
		for j in range(0, bodies.size()):
			if i != j:
				var force = attract(bodies[i], bodies[j])
				bodies[i].apply_force(force)
func attract(rb1 : MoverPlanet, rb2 : MoverPlanet) -> Vector2:
	var force: Vector2 = rb1.global_position.direction_to(rb2.global_position)
	var distance = rb1.global_position.direction_to(rb2.global_position).length()
	distance = clamp(distance, 0.1, 1000)
	var strength = (G * rb1.mass * rb2.mass) / (distance * distance)
	force = force.normalized() * strength
	return force
