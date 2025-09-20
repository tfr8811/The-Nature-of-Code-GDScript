extends Area2D

@export var target_scene_path : String
func _on_body_entered(body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", target_scene_path)
