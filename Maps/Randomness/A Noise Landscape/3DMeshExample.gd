@tool
extends MeshInstance3D
func _ready() -> void:
	var mesh_data = []
	mesh_data.resize(ArrayMesh.ARRAY_MAX)
	mesh_data[ArrayMesh.ARRAY_VERTEX] = PackedVector3Array(
		[
			Vector3(0,0,0),
			Vector3(1,0,0),
			Vector3(1,1,0),
			Vector3(0,1,0)
		]
	)
	mesh_data[ArrayMesh.ARRAY_INDEX] = PackedInt32Array(
		[
			0,1,2,
			0,2,3
		]
	)
	mesh_data[ArrayMesh.ARRAY_NORMAL] = PackedVector3Array(
		[
			Vector3(0,0,-1),
			Vector3(0,0,-1),
			Vector3(0,0,-1),
			Vector3(0,0,-1)
		]
	)
	mesh_data[ArrayMesh.ARRAY_TEX_UV] = PackedVector2Array(
		[
			Vector2(1,1),
			Vector2(0,1),
			Vector2(0,0),
			Vector2(1,0)
		]
	)
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, mesh_data)
