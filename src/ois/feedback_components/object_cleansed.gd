extends Feedback

@export var cursed_mesh : Node3D
@export var cleansed_mesh : Node3D

func show_feedback(requirement, total_progress):
	cursed_mesh.visible = false
	cleansed_mesh.visible = true
