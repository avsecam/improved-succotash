extends Node3D

@onready var cursed_mesh := $"../MainMesh/CursedMesh"
@onready var clean_mesh := $"../MainMesh/CleansedMesh"

@onready var cursed_particles = $"../CursedParticles"
@onready var blessed_particles = $"../BlessedParticles"


func _on_associated_event_finished() -> void:
	cursed_mesh.visible = false
	clean_mesh.visible = true
	cursed_particles.emitting = false
