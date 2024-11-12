extends XRToolsPickable


func _on_action_ship_assembly_complete_tree_exiting():
	queue_free()
