extends Node3D


@onready var camera: XRCamera3D = %XRCamera3D

func _ready():
	Events.start_without_vr.connect(_on_start_without_vr)

func _on_start_without_vr():
	print("Freeing XRPlayer...")
	queue_free()
