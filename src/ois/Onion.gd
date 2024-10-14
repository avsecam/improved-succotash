extends XRToolsPickable

signal onion_chopped
# Called when the node enters the scene tree for the first time

func _on_onion_receiver_action_completed(requirement, total_progress):
	onion_chopped.emit()
