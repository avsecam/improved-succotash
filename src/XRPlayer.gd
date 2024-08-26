extends Node3D


@onready var camera: XRCamera3D = %XRCamera3D
@onready var origin: XROrigin3D = %XROrigin3D

func _ready():
	Events.start_without_vr.connect(_on_start_without_vr)

func _physics_process(_delta):
	# origin.position.x = 0
	# origin.position.z = 0
	
	Events.xr_camera_moved.emit(camera.global_position, camera.global_rotation)

func _on_start_without_vr():
	print("Freeing XRPlayer...")
	queue_free()
