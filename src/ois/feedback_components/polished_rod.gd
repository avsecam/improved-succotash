extends Feedback

@onready var dirt := $"../../Node3D"

func show_feedback(requirement, total_progress):
	dirt.visible = false