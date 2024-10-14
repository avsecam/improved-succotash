extends XRToolsPickable

signal kalabasa_chopped

func _on_kalabasa_receiver_action_completed(requirement, total_progress):
	kalabasa_chopped.emit()
