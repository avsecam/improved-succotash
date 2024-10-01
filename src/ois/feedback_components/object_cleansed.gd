extends Feedback

@export var cursed_mesh : Node3D
@export var cleansed_mesh : Node3D

func show_feedback(requirement, total_progress):
	pass

func _on_pillar_a_2_action_started(requirement, total_progress):
	cursed_mesh.visible = false
	cleansed_mesh.visible = true
