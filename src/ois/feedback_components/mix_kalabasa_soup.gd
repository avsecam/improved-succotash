extends Feedback

@onready var kalabasa_soup_mixed = $"../MainMesh/KalabasaSoupMixed"
@onready var kalabasa_soup_unmixed = $"../MainMesh/KalabasaSoupUnmixed"

func show_feedback(requirement, total_progress):
	pass

	
func _on_cooking_vat_long_action_ended(requirement, total_progress):
	kalabasa_soup_unmixed.visible = false
	kalabasa_soup_mixed.visible = true
