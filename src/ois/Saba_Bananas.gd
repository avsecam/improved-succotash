extends XRToolsPickable

func _on_associated_event_finished():
	queue_free()


func _on_action_all_atchara_ingredients_tree_exiting():
	self.visible = true
