extends Feedback

@export var cursed_mesh : Node3D
@export var cleansed_mesh : Node3D
@onready var progress_view = $"../Progress View"
@onready var collision_shape_3d = $"../CollisionShape3D"
@onready var cursed_particles = $"../CursedParticles"
@onready var blessed_particles = $"../BlessedParticles"

func show_feedback(requirement, total_progress):
	AudioHandler.play_sfx("A_Purify", $"../AudioStreamPlayer3D")
	cursed_mesh.visible = false
	cleansed_mesh.visible = true
	cursed_particles.emitting = false
	cursed_particles.visible = false
	blessed_particles.emitting = true
	
	progress_view.visible = true
	progress_view.progress_complete_checkmark_only_anim()
	collision_shape_3d.disabled = true
	




