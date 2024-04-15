extends Feedback

@export var animation_player : AnimationPlayer
@export var animation_name : String

func show_feedback(requirement, total_progress):
	if action_completed:
		# handle this in receiver in future
		if (requirement > 0 && total_progress >= requirement || requirement < 0 && total_progress <= requirement):
			animation_player.play(animation_name)
			print(name + " playing")
	else:
		print(name + " playing")
		animation_player.play(animation_name)
