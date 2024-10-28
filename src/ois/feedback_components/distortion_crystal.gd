extends Feedback


@onready var crystal_mesh := $"../MainMesh/Dark_Crystal"

func show_feedback(requirement, total_progress):
	print("SMASHING DISTORTION CCRYSTAL")
	crystal_mesh.anim.play("smash")
	await crystal_mesh.anim.animation_finished
	
	get_parent().queue_free()
