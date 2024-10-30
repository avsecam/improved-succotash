extends Feedback

@export var animation_player : AnimationPlayer
@export var animation_name : String
@export var done:bool = false

func show_feedback(requirement, total_progress):
	if !done:
		animation_player.play(animation_name)
		done = true


func _on_receiver_comp_action_in_progress(requirement, total_progress):
	if total_progress < 0:
		get_parent().total_progress = 0
