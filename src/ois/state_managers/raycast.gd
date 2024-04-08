extends Node3D

@export var raycast_length = 1.0
@export var laser_thickness = 0.002

@onready var raycast = $RayCast3D
@onready var laser = $Laser

var currently_colliding

signal body_entered(body)
signal body_exited(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	# set raycast and laser properties
	raycast.target_position.z = -raycast_length
	laser.mesh.size = Vector3(laser_thickness, laser_thickness, raycast_length)
	laser.position.z = -(raycast_length/2)

func enable_raycast(enable):
	raycast.enabled = enable
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
