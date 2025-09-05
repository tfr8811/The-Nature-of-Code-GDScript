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
var undoRedo = UndoRedo.new()
var nextStep = Vector2(0, 0)
func _physics_process(delta):
	nextStep = Vector2(0, 0)
	if (Input.is_action_just_pressed("Backward") && !raycastS.is_colliding()):
		nextStep.y += STEP_SIZE
	elif (Input.is_action_just_pressed("Forward") && !raycastN.is_colliding()):
		nextStep.y -= STEP_SIZE
	elif (Input.is_action_just_pressed("Left") && !raycastW.is_colliding()):
		nextStep.x -= STEP_SIZE
	elif (Input.is_action_just_pressed("Right") && !raycastE.is_colliding()):
		nextStep.x += STEP_SIZE
	elif (Input.is_action_just_pressed("WarpSouth") && !raycastSLong.is_colliding()):
		nextStep.y += STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpNorth") && !raycastNLong.is_colliding()):
		nextStep.y -= STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpWest") && !raycastWLong.is_colliding()):
		nextStep.x -= STEP_SIZE * mapDimensions.x
	elif (Input.is_action_just_pressed("WarpEast") && !raycastELong.is_colliding()):
		nextStep.x += STEP_SIZE * mapDimensions.x
	elif (Input.is_action_just_pressed("Undo")):
		undoRedo.undo()
	if nextStep.length() != 0:
		undoRedo.create_action("Move Player")
		undoRedo.add_do_method(MovePlayer.bind(nextStep))
		undoRedo.add_undo_method(MovePlayer.bind(-nextStep))
		undoRedo.commit_action()

func MovePlayer(step : Vector2):
	position += step
