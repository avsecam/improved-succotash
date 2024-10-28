extends Feedback

@export var cursed_floor_mesh: Node3D


func show_feedback(requirement, total_progress):
	cursed_floor_mesh.visible = false
	if (total_progress >= requirement):
		print("Floor is purified")
