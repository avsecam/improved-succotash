extends Feedback

@export var teleporter : Teleporter

func show_feedback(requirement, total_progress):	
	if (requirement > 0 && total_progress >= requirement || requirement < 0 && total_progress <= requirement):
		teleporter.enabled = true
