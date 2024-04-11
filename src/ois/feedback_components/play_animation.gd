extends Feedback

@export var animation_player : AnimationPlayer
@export var animation_name : String

func show_feedback(requirement, total_progress):
	if (requirement > 0 && total_progress >= requirement || requirement < 0 && total_progress <= requirement):
		animation_player.play(animation_name)
