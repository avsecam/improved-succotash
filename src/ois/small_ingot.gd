extends XRToolsPickable
@onready var collision_shape_3d = $CollisionShape3D

func disable_collision():
	collision_shape_3d.disabled = true


func _on_action_put_ingot_in_crucible_event_ended():
	self.queue_free()
