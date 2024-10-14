extends XRToolsPickable

signal garlic_chopped

func _on_garlic_receiver_action_completed(requirement, total_progress):
	garlic_chopped.emit()
