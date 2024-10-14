extends XRToolsPickable


signal papaya_grated


func _on_feedback_papaya_grated_workaround():
	papaya_grated.emit()
