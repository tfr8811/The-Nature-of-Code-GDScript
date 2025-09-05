extends CharacterBody2D

const STEP_SIZE = 64
var mapDimensions = Vector2(9, 6)
@export var raycastN : RayCast2D
@export var raycastS : RayCast2D
@export var raycastE : RayCast2D
@export var raycastW : RayCast2D
@export var raycastNLong : RayCast2D
@export var raycastSLong : RayCast2D
@export var raycastELong : RayCast2D
@export var raycastWLong : RayCast2D
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if (Input.is_action_just_pressed("Backward") && !raycastS.is_colliding()):
		position.y += STEP_SIZE
	elif (Input.is_action_just_pressed("Forward") && !raycastN.is_colliding()):
		position.y -= STEP_SIZE
	elif (Input.is_action_just_pressed("Left") && !raycastW.is_colliding()):
		position.x -= STEP_SIZE
	elif (Input.is_action_just_pressed("Right") && !raycastE.is_colliding()):
		position.x += STEP_SIZE
	if (Input.is_action_just_pressed("WarpSouth") && !raycastSLong.is_colliding()):
		position.y += STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpNorth") && !raycastNLong.is_colliding()):
		position.y -= STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpWest") && !raycastWLong.is_colliding()):
		position.x -= STEP_SIZE * mapDimensions.x
	elif (Input.is_action_just_pressed("WarpEast") && !raycastELong.is_colliding()):
		position.x += STEP_SIZE * mapDimensions.x
