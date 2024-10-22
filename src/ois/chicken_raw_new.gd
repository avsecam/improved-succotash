extends XRToolsPickable
@onready var collision_shape_3d = $CollisionShape3D

func disable_collision():
	collision_shape_3d.disabled = true

