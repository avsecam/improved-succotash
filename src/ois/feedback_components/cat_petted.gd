extends Feedback

var anim_check : bool

@onready var progress_view = $"../Progress View"

func show_feedback(requirement, total_progress):
	if (total_progress >= requirement):
		print("Cat is Petted")
		
			

func _on_cat_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	print("Cat pat progress: " + str(percentage*100)+"%")
	progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	if percentage >= 1:
		if !anim_check:
			progress_view.progress_complete_anim()
			anim_check = true
