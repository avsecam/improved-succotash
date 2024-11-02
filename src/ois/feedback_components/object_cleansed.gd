extends Feedback

@export var cursed_mesh : Node3D
@export var cleansed_mesh : Node3D
@onready var progress_view = $"../Progress View"

func show_feedback(requirement, total_progress):
	cursed_mesh.visible = false
	cleansed_mesh.visible = true
	progress_view.visible = true
	progress_view.progress_complete_checkmark_only_anim()
	



