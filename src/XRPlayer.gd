extends Node3D


@onready var camera: XRCamera3D = %XRCamera3D

func _ready():
	Events.start_without_vr.connect(_on_start_without_vr)
	
	camera.add_child(preload("res://src/areas/Outside0.jpg.tscn").instantiate())

func _on_start_without_vr():
	print("Freeing XRPlayer...")
	queue_free()
