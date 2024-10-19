extends Feedback

@onready var kalabasa_soup_mixed = $"../MainMesh/KalabasaSoupMixed"
@onready var kalabasa_soup_unmixed = $"../MainMesh/KalabasaSoupUnmixed"
@onready var progress_view = $"../Progress View"

func show_feedback(requirement, total_progress):
	pass

	
func _on_cooking_vat_long_action_ended(requirement, total_progress):
	kalabasa_soup_unmixed.visible = false
	kalabasa_soup_mixed.visible = true
	progress_view.progress_complete_anim()


func _on_cooking_vat_long_action_in_progress(requirement, total_progress):
	
	var percentage = total_progress/requirement
	print("Kalabasa soup mixing progress: " + str(percentage*100)+"%")
	progress_view.change_progress_value(percentage*100)
