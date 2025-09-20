extends Area2D
class_name PushableBlock
@export var raycastN : RayCast2D
@export var raycastS : RayCast2D
@export var raycastE : RayCast2D
@export var raycastW : RayCast2D

func CanMove(step : Vector2) -> bool:
	if (step.normalized() == Vector2.UP && raycastN.is_colliding()):
		return false
	if (step.normalized() == Vector2.DOWN && raycastS.is_colliding()):
		return false
	if (step.normalized() == Vector2.RIGHT && raycastE.is_colliding()):
		return false
	if (step.normalized() == Vector2.LEFT && raycastW.is_colliding()):
		return false
	return true
