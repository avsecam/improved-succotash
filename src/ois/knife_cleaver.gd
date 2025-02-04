extends XRToolsPickable



func _on_action_after_chicken_skewer_tree_exiting():
	self.visible = true


func _on_action_all_atchara_ingredients_tree_exiting():
	self.visible = false
