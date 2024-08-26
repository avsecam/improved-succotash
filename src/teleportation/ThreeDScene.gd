@tool
class_name ThreeDScene
extends Level

@export var obj_filename: String

func _ready():
	super()
	
	assert(obj_filename, "No obj_filename found for 3D scene, "+ obj_filename)
	var mesh_file = load(obj_filename)
	assert(mesh_file, "obj_filename cannot be loaded: " + obj_filename)
	mesh_instance.mesh = mesh_file
	mesh_instance.create_trimesh_collision()

func _physics_process(delta):
	super(delta)
