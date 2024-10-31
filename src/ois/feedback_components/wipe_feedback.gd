extends Feedback

@export var dirt_mesh : Node3D
@onready var progress_view = $"../Progress View"

func show_feedback(requirement, total_progress):
	dirt_mesh.visible = false


func _on_dirt_action_in_progress(requirement, total_progress):
	progress_view.visible = true
	var percentage = total_progress/requirement
	
	progress_view.change_progress_value(percentage*100)
