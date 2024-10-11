extends Feedback

@export var garlica : Node3D
@export var garlicb : Node3D

func _on_garlic_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	print("Garlic chop progress: " + str(percentage*100)+"%")

func _on_garlic_receiver_action_completed(requirement, total_progress):
	garlica.visible = false
	garlicb.visible = true
		
