extends Node3D
var original_position: Vector3
var original_rotation: Quaternion 
@onready var parent
@export var bounds_y = -0.95
@export var bounds_x = 2.2
@export var bounds_z = 2.2

func _ready():
	if get_parent():
		parent = get_parent()
		original_position = get_parent().global_transform.origin
		original_rotation = get_parent().global_transform.basis.get_rotation_quaternion()

func _process(delta):
	if parent.global_transform.origin.y < bounds_y or abs(parent.global_transform.origin.x) > bounds_x or abs(parent.global_transform.origin.z) > bounds_z:
		print("I AM OUT PLEASE RETURN ME")
		parent.linear_velocity = Vector3.ZERO
		parent.angular_velocity = Vector3.ZERO
		reset_parent_position()

func reset_parent_position():
	if get_parent():
		parent.global_transform.origin = original_position
		parent.global_transform.basis = Basis(original_rotation)
