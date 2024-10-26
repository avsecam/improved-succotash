extends Feedback

@onready var kalabasa_soup_mixed = $"../MainMesh/KalabasaSoupMixed"
@onready var kalabasa_soup_unmixed = $"../MainMesh/KalabasaSoupUnmixed"
@onready var progress_view = $"../Progress View"

var anim_check : bool
var cooking_vat_progress : float
signal kalabasa_mix_finished

func show_feedback(requirement, total_progress):
	pass

func _ready():
	super()
	cooking_vat_progress = 0

func _on_cooking_vat_long_action_in_progress(requirement, total_progress):
	
	var percentage = total_progress/requirement
	#cooking_vat_progress += 0.01
	
	print("Kalabasa soup mixing progress: " + str(percentage*100)+"%")
	progress_view.change_progress_value(percentage*100)
	
	if percentage >= 1:
		if !anim_check:
			kalabasa_soup_unmixed.visible = false
			kalabasa_soup_mixed.visible = true
			progress_view.progress_complete_anim()
			anim_check = true
			kalabasa_mix_finished.emit()
