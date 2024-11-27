extends MeshInstance3D

var boolredudance : bool


func _on_action_forge_operation_indicator_event_ended():
	boolredudance = true
	self.visible = false

func _on_action_put_crucible_in_forge_tree_exiting():
	if !boolredudance:
		self.visible = true
