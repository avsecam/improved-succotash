extends Feedback


@onready var crystal_mesh := $"../MainMesh/Dark_Crystal"
@onready var particle_emission = $"../../MagicalDistortion/GPUParticles3D"
func show_feedback(requirement, total_progress):
	print("SMASHING DISTORTION CRYSTAL")
	crystal_mesh.anim.play("smash")
	particle_emission.emitting = false
	AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
	await crystal_mesh.anim.animation_finished
	
	get_parent().queue_free()
