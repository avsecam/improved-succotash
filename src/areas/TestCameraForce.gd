extends Node3D


@onready var origin := XRHelpers.get_xr_origin(self.get_parent())
@onready var camera : XRCamera3D = XRHelpers.get_xr_camera(self.get_parent())
@onready var teleport_mesh
@onready var new_tp_mesh : Vector3
@onready var test_lol : Node3D =  camera.get_child(3)
@onready var loltest
@onready var test_lol_pos : Vector3
@onready var camera_pos : Vector3

@onready var dot_prod
@onready var cross_prod
@onready var vec1sqrt
@onready var vec2sqrt
@onready var firstloltest

# Called when the node enters the scene tree for the first time.
func _ready():
	teleport_mesh = get_parent().teleporters_data[0]["position"]
	new_tp_mesh = Vector3(teleport_mesh.x,0,teleport_mesh.z)
	
	camera_pos = camera.global_transform.origin
	
	#print("==========CAMERA ROTATION PRE:" + str(origin.rotation.y))
	test_lol_pos = Vector3(test_lol.global_position.x,0,test_lol.global_position.z)
	
	dot_prod = test_lol_pos.x * new_tp_mesh.x + test_lol_pos.z * new_tp_mesh.z
	cross_prod = test_lol_pos.x * new_tp_mesh.z + test_lol_pos.z * new_tp_mesh.x
	
	vec1sqrt = sqrt(test_lol_pos.x * test_lol_pos.x + test_lol_pos.z * test_lol_pos.z)
	vec2sqrt = sqrt(new_tp_mesh.x * new_tp_mesh.x + new_tp_mesh.z * new_tp_mesh.z)
	
	#loltest = acos(test_lol_pos.cross(new_tp_mesh).length()/(test_lol_pos.length()*new_tp_mesh.length()))
	loltest = atan2(abs(cross_prod),dot_prod) * 180/PI
	if (cross_prod < 0):
		loltest = 360 - loltest
		
		
	firstloltest = loltest
	print("==========INITIALIZED VALUE:"+str(loltest))
	
	if loltest < 20 and loltest > -20:
		pass
	else:
		origin.rotation_degrees.y -= loltest

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
	
	

	
	
