extends Feedback

@export var animation_player : AnimationPlayer
@export var animation_name : String

func show_feedback(requirement, total_progress):
	animation_player.play(animation_name)
