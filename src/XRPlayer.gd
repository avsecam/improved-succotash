extends Node3D


@onready var camera: XRCamera3D = %XRCamera3D
@onready var origin: XROrigin3D = %XROrigin3D

func _ready():
	Events.start_without_vr.connect(_on_start_without_vr)

func _physics_process(_delta):
	origin.position = Vector3()

func _on_start_without_vr():
	print("Freeing XRPlayer...")
	queue_free()
