extends Node3D
var original_position: Vector3
var original_rotation: Quaternion 
@onready var parent
@export var bounds_y = -1.15
@export var bounds_x = 2.2
@export var bounds_z = 2.2
@export var parent_current_pos : Vector3
@export var parent_local_pos : Vector3

func _ready():
	if get_parent():
		parent = get_parent()
		original_position = get_parent().transform.origin
		original_rotation = get_parent().transform.basis.get_rotation_quaternion()

func _process(delta):
	parent_current_pos = parent.global_transform.origin
	parent_local_pos = parent.transform.origin
	if parent.transform.origin.y < bounds_y or abs(parent.transform.origin.x) > bounds_x or abs(parent.transform.origin.z) > bounds_z:
		print("I AM OUT PLEASE RETURN ME")
		parent.linear_velocity = Vector3.ZERO
		parent.angular_velocity = Vector3.ZERO
		reset_parent_position()

func reset_parent_position():
	if get_parent():
		parent.transform.origin = original_position
		parent.transform.basis = Basis(original_rotation)
