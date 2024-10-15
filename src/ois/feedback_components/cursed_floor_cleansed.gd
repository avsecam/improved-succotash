extends Feedback

@export var cursed_floor_mesh: Node3D


func show_feedback(requirement, total_progress):
	if (total_progress >= requirement):
		print("Floor is purified")

func _on_cursed_floor_action_completed(requirement, total_progress):
	cursed_floor_mesh.visible = false


func _on_cursed_floor_action_started(requirement, total_progress):
	cursed_floor_mesh.visible = false
