extends MeshInstance3D

var boolredudance : bool

func _on_action_put_ingot_in_crucible_event_ended():
	if !boolredudance:
		self.visible = true

func _on_action_forge_operation_indicator_event_ended():
	boolredudance = true
	self.visible = false
