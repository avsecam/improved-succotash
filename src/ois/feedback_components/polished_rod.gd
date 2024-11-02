extends Feedback

@export var dirt : Node3D
@onready var progress_view = $"../../Progress View"

func show_feedback(requirement, total_progress):
	dirt.visible = false


func _on_oiled_rag_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	
