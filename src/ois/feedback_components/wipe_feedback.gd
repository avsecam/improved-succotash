extends Feedback

@export var dirt_mesh : Node3D

func show_feedback(requirement, total_progress):
	dirt_mesh.visible = false
