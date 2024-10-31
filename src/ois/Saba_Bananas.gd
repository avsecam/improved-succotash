extends XRToolsPickable

func _on_associated_event_finished():
	queue_free()
