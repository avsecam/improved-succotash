extends MeshInstance3D

var boolredudance : bool

func _on_action_put_ingot_in_crucible_tree_exiting():
	if !boolredudance:
		self.visible = true

func _on_action_put_crucible_in_forge_tree_exiting():
	boolredudance = true
	self.visible = false
