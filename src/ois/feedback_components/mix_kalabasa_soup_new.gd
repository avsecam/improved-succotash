extends Feedback


var anim_check : bool

@onready var progress_view = $"../Progress View"
@onready var kalabasa_soup_mixed = $"../MainMesh/KalabasaSoupMixed"
@onready var kalabasa_soup_unmixed = $"../MainMesh/KalabasaSoupUnmixed"

signal mix_complete

func _on_kalabasa_soup_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	print("Kalabasa soup mixing progress: " + str(percentage*100)+"%")
	progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	if percentage >= 1:
		if !anim_check:
			kalabasa_soup_unmixed.visible = false
			kalabasa_soup_mixed.visible = true
			progress_view.progress_complete_anim()
			anim_check = true
			mix_complete.emit()
