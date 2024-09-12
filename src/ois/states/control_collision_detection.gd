@tool
extends StateBehavior

@onready var collision_area = $Area3D
@onready var collision_shape = $Area3D/CollisionShape3D
@onready var laser = $Laser
@onready var mesh = $MeshInstance3D

@export var collision_mesh_radius = 0.1
@export var laser_thickness = 0.002

var is_enabled = false

signal body_entered(body)
signal body_exited(body)

func on_enter_state():
	enable_collision(true)

func on_exit_state():
	enable_collision(false)

func _ready():
	# set raycast and laser properties
	
	collision_shape.shape.radius = collision_mesh_radius
	laser.mesh.size = Vector3(laser_thickness, laser_thickness, collision_mesh_radius*2)
	#laser.position.z = -collision_mesh_radius
	mesh.mesh.radius = collision_mesh_radius
	mesh.mesh.height = collision_mesh_radius*2
	
	var parent = get_parent()
	if parent is StateManager:
		body_entered.connect(parent._on_receiver_collision_entered)
		body_exited.connect(parent._on_receiver_collision_exited)

func enable_collision(enable):
	is_enabled = enable
	laser.visible = enable
	mesh.visible = enable

func _on_area_3d_area_entered(area):
	if is_enabled:
		body_entered.emit(area)

func _on_area_3d_area_exited(area):
	if is_enabled:
		body_exited.emit(area)

func _on_area_3d_body_entered(body):
	if is_enabled:
		body_entered.emit(body)

func _on_area_3d_body_exited(body):
	if is_enabled:
		body_exited.emit(body)
