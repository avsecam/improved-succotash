extends XRToolsPickable


func _on_action_arrange_documents_tree_exiting():
	queue_free()
