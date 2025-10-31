extends CharacterBody2D
const STEP_SIZE = 64
@export var mapDimensions = Vector2(9, 6)
@export var pushEnabled : bool
@export var raycastN : RayCast2D
@export var raycastS : RayCast2D
@export var raycastE : RayCast2D
@export var raycastW : RayCast2D
@export var raycastNLong : RayCast2D
@export var raycastSLong : RayCast2D
@export var raycastELong : RayCast2D
@export var raycastWLong : RayCast2D
@export var areaN : Area2D
@export var areaS : Area2D
@export var areaE : Area2D
@export var areaW : Area2D
var undoRedo = UndoRedo.new()
var nextStep = Vector2(0, 0)
var pushableBlock : PushableBlock
var illegalMove = false
# for z hold behaviour
var undoInitialCooldown = 0.5
var undoHeldCooldown = 0.1
var undoCooldownTimer = 0
func _ready() -> void:
	raycastNLong.target_position.y = -STEP_SIZE * mapDimensions.y
	raycastNLong.target_position.x = 0
	raycastSLong.target_position.y = STEP_SIZE * mapDimensions.y
	raycastSLong.target_position.x = 0
	raycastELong.target_position.x = STEP_SIZE * mapDimensions.x
	raycastELong.target_position.y = 0
	raycastWLong.target_position.x = -STEP_SIZE * mapDimensions.x
	raycastWLong.target_position.y = 0
	# set the areas
	areaN.position = raycastNLong.target_position
	areaS.position = raycastSLong.target_position
	areaE.position = raycastELong.target_position
	areaW.position = raycastWLong.target_position
	
func _physics_process(delta):
	nextStep = Vector2(0, 0)
	if (Input.is_action_just_pressed("Backward")):
		if !raycastS.is_colliding(): nextStep.y += STEP_SIZE
		elif pushEnabled && raycastS.get_collider().is_in_group("pushable"):
			pushableBlock = raycastS.get_collider()
			nextStep.y += STEP_SIZE
	elif (Input.is_action_just_pressed("Forward")):
		if !raycastN.is_colliding(): nextStep.y -= STEP_SIZE
		elif pushEnabled && raycastN.get_collider().is_in_group("pushable"):
			pushableBlock = raycastN.get_collider()
			nextStep.y -= STEP_SIZE
	elif (Input.is_action_just_pressed("Left")):
		if !raycastW.is_colliding(): nextStep.x -= STEP_SIZE
		elif pushEnabled && raycastW.get_collider().is_in_group("pushable"):
			pushableBlock = raycastW.get_collider()
			nextStep.x -= STEP_SIZE
	elif (Input.is_action_just_pressed("Right")):
		if !raycastE.is_colliding(): nextStep.x += STEP_SIZE
		elif pushEnabled && raycastE.get_collider().is_in_group("pushable"):
			pushableBlock = raycastE.get_collider()
			nextStep.x += STEP_SIZE
	elif (Input.is_action_just_pressed("WarpSouth") 
	&& !raycastSLong.is_colliding()
	&& !areaS.has_overlapping_bodies()):
		nextStep.y += STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpNorth") 
	&& !raycastNLong.is_colliding()
	&& !areaN.has_overlapping_bodies()):
		nextStep.y -= STEP_SIZE * mapDimensions.y
	elif (Input.is_action_just_pressed("WarpWest") 
	&& !raycastWLong.is_colliding()
	&& !areaW.has_overlapping_bodies()):
		nextStep.x -= STEP_SIZE * mapDimensions.x
	elif (Input.is_action_just_pressed("WarpEast") 
	&& !raycastELong.is_colliding()
	&& !areaE.has_overlapping_bodies()):
		nextStep.x += STEP_SIZE * mapDimensions.x
	elif (Input.is_action_just_pressed("Undo")):
		undoRedo.undo()
		undoCooldownTimer = undoInitialCooldown
	elif (Input.is_action_pressed("Undo")):
		if undoCooldownTimer <= 0:
			undoRedo.undo()
			undoCooldownTimer = undoHeldCooldown
		else:
			undoCooldownTimer -= delta
	if nextStep.length() != 0:
		if pushableBlock != null:
			if (pushableBlock.CanMove(nextStep)):
				undoRedo.create_action("Push Block")
				undoRedo.add_do_method(PushBlock.bind(nextStep, pushableBlock))
				undoRedo.add_undo_method(PushBlock.bind(-nextStep, pushableBlock))
				undoRedo.commit_action()
		else:
			undoRedo.create_action("Move Player")
			undoRedo.add_do_method(MovePlayer.bind(nextStep))
			undoRedo.add_undo_method(MovePlayer.bind(-nextStep))
			undoRedo.commit_action()
	pushableBlock = null
	# restart
	if (Input.is_action_just_pressed("Reset")):
		get_tree().reload_current_scene()

func MovePlayer(step : Vector2):
	position += step

func PushBlock(step : Vector2, block : Area2D):
	position += step
	block.position += step
func CanAct(initialPress : bool, delta : float) -> bool:
	var _canAct = false
	if (initialPress):
		_canAct = true
		undoCooldownTimer = undoInitialCooldown
	else:
		if undoCooldownTimer <= 0:
			_canAct = true
			undoCooldownTimer = undoHeldCooldown
		else:
			undoCooldownTimer -= delta
	return _canAct
