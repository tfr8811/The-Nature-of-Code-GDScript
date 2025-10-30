extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 40000.0
const AIR_SPEED = 500.0
@export var sight : Area2D
@export var ground_detection : RayCast2D
@export var camera : Camera2D
var acceleration : Vector2

func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity *= 0
	#var on_floor = ground_detection.is_colliding()
	# set the up direction
	if get_nearest_body() != null:
		var nearest_body : Node2D = get_nearest_body()
		var distance_to_nearest_body = nearest_body.global_position.distance_to(self.global_position)
		#up_direction = nearest_body.global_position.direction_to(self.global_position).normalized()
		up_direction = find_surface_normal(nearest_body)
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
	# update camera
	# remapping to make rotation slower if the player swaps planets, but faster for general movement
	var rotation_factor = remap(abs(angle_difference(camera.global_rotation,global_rotation)), 0, PI, 5, 1)
	camera.global_rotation = lerp_angle(camera.global_rotation, global_rotation, rotation_factor * delta)
	camera.global_position = lerp(camera.global_position, global_position, rotation_factor * delta)

func get_nearest_body():
	var nearest_body
	if sight.has_overlapping_bodies():
		var overlappers = sight.get_overlapping_bodies()
		nearest_body = overlappers[0]
		if (overlappers.size() > 0):
			for overlapper in overlappers:
				if overlapper == nearest_body: continue
				#var dist1 = nearest_body.global_position.distance_to(self.global_position)
				#var dist2 = overlapper.global_position.distance_to(self.global_position)
				var dist1 = find_closest_dist(nearest_body)
				var dist2 = find_closest_dist(overlapper)
				if dist2 < dist1:
					nearest_body = overlapper
	return nearest_body
func find_closest_dist(overlapper: CollisionObject2D) -> float:
	var _space_state = get_world_2d().direct_space_state
	var _to_center = overlapper.global_position - global_position
	var _ray_length = _to_center.length()
	var _query = PhysicsRayQueryParameters2D.create(global_position, overlapper.global_position)
	_query.collide_with_areas = true
	_query.collide_with_bodies = true
	_query.exclude = [self]

	var _result = _space_state.intersect_ray(_query)

	if _result:
		return global_position.distance_to(_result.position)
	else:
		# if nothing was hit (rare, maybe if overlapper is disabled)
		return _ray_length
func find_surface_normal(overlapper: CollisionObject2D) -> Vector2:
	var _space_state = get_world_2d().direct_space_state
	var _to_center = overlapper.global_position - global_position
	var _ray_length = _to_center.length()
	var _query = PhysicsRayQueryParameters2D.create(global_position, overlapper.global_position)
	_query.collide_with_areas = true
	_query.collide_with_bodies = true
	_query.exclude = [self]

	var _result = _space_state.intersect_ray(_query)

	if _result:
		return _result.normal
	else:
		# if nothing was hit (rare, maybe if overlapper is disabled)
		return -_to_center.normalized()
