@tool
extends MeshInstance3D

@export var size : int = 32
@export var subdivide : int = 31
@export var amplitude : int = 16
@export var noise = FastNoiseLite.new()
@export var collision_shape : CollisionShape3D
@export var noiseSpeed : float
# time increment
var tNoise = 2000.0
func _ready() -> void:
	generate_terrain()
func _physics_process(delta: float) -> void:
	tNoise += delta*noiseSpeed
	generate_terrain()
func generate_terrain():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size,size)
	plane_mesh.subdivide_depth = subdivide
	plane_mesh.subdivide_width = subdivide
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var data = surface_tool.commit_to_arrays()
	var vertices = data[ArrayMesh.ARRAY_VERTEX]
	
	for i in vertices.size():
		var vertex = vertices[i]
		vertices[i].y = noise.get_noise_3d(vertex.x, vertex.z, tNoise) * amplitude
	data[ArrayMesh.ARRAY_VERTEX] = vertices
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, data)
	
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	
	mesh = surface_tool.commit()
	collision_shape.shape = array_mesh.create_trimesh_shape()
