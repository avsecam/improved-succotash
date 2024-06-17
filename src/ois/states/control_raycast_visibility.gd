#@tool
extends StateBehavior
class_name SBRaycastVisibility

@onready var raycast = $RayCast3D
@onready var laser = $Laser

@export var raycast_length = 1.0:
	set(value):
		raycast_length = value
		if raycast != null:
			set_raycast_size(raycast_length, laser_thickness)
@export var laser_thickness = 0.002:
	set(value):
		laser_thickness = value
		if raycast != null:
			set_raycast_size(raycast_length, laser_thickness)

var currently_colliding

signal body_entered(body)
signal body_exited(body)

func on_enter_state():
	enable_raycast(true)

func on_exit_state():
	enable_raycast(false)

func _ready():
	#debug_show(false)
	# set raycast and laser properties
	
	set_raycast_size(raycast_length, laser_thickness)
	
	var parent = get_parent()
	if parent is StateManager:
		body_entered.connect(parent._on_receiver_collision_entered)
		body_exited.connect(parent._on_receiver_collision_exited)

	enable_raycast(false)
	
func set_raycast_size(raycast_length, laser_thickness):
	print(raycast)
	raycast.target_position.z = -raycast_length
	laser.mesh.size = Vector3(laser_thickness, laser_thickness, raycast_length)
	laser.position.z = -(raycast_length/2)

func enable_raycast(enable):
	laser.visible = enable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (raycast.is_colliding()):
		if (currently_colliding == null):
			currently_colliding = raycast.get_collider()
			body_entered.emit(currently_colliding)
	else:
		if (currently_colliding != null):
			body_exited.emit(currently_colliding)
			currently_colliding = null

#func debug_show(to_show):
	#$Debug.visible = to_show
