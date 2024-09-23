extends Feedback

@export var animation_player : AnimationPlayer
@export var animation_name : String
@export var done:bool = false

func show_feedback(requirement, total_progress):
	if !done:
		animation_player.play(animation_name)
		done = true
