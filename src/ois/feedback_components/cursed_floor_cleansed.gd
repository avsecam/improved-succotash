extends Feedback

@export var cursed_floor_mesh: Node3D

func _on_cursed_floor_action_started(requirement, total_progress):
	cursed_floor_mesh.visible = false
