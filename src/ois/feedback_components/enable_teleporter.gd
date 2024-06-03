extends Feedback

@export var teleporter : Teleporter

func show_feedback(requirement, total_progress):
	teleporter.enabled = true
