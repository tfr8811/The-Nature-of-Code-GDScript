extends Node3D
@export var scenePath: String


func _on_area_3d_body_entered(body):
	call_deferred("change_level");

func change_level():
	get_tree().change_scene_to_file(scenePath)
