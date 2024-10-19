extends Feedback

@export var garlica : Node3D
@export var garlicb : Node3D
@onready var progress_view = $"../Progress View"

func _on_garlic_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	if progress_view.visible == false:
		progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	print("Garlic chop progress: " + str(percentage*100)+"%")

func _on_garlic_receiver_action_completed(requirement, total_progress):
	garlica.visible = false
	garlicb.visible = true
	
	progress_view.progress_complete_anim()
		
