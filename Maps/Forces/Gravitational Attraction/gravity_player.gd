extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 40000.0
const AIR_SPEED = 500.0
@export var sight : Area2D
@export var ground_detection : RayCast2D
var acceleration : Vector2

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity *= 0
	#var on_floor = ground_detection.is_colliding()
	# set the up direction
	if get_nearest_body() != null:
		var nearest_body : Node2D = get_nearest_body()
		var distance_to_nearest_body = nearest_body.global_position.distance_to(self.global_position)
		up_direction = nearest_body.global_position.direction_to(self.global_position).normalized()
		# Add the gravity.
		acceleration += -up_direction * distance_to_nearest_body * distance_to_nearest_body * delta
		self.global_rotation = up_direction.angle()+PI/2
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		acceleration += up_direction * JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if is_on_floor():
			velocity = up_direction.rotated(PI/2) * direction * SPEED
		else:
			acceleration += up_direction.rotated(PI/2) * direction * AIR_SPEED
	acceleration += -velocity/2
	velocity += acceleration * delta
	acceleration *= 0
	if get_nearest_body() != null && get_nearest_body() is MoverPlanet:
		global_position += get_nearest_body().velocity * delta
	move_and_slide()

func get_nearest_body():
	var nearest_body
	if sight.has_overlapping_bodies():
		var overlappers = sight.get_overlapping_bodies()
		nearest_body = overlappers[0]
		if (overlappers.size() > 0):
			for overlapper in overlappers:
				if overlapper == nearest_body: continue
				var dist1 = nearest_body.global_position.distance_to(self.global_position)
				var dist2 = overlapper.global_position.distance_to(self.global_position)
				if dist2 < dist1:
					nearest_body = overlapper
	return nearest_body
