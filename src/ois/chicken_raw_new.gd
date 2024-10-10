extends XRToolsPickable

@onready var collision_shape = $CollisionShape3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.get_parent().name == "Inventory Content" and collision_shape.disabled == false:
		collision_shape.disabled = true
		print("ASAAAAAA DISABLED COLLISION CHICKEN")
		self.get_parent().get_parent().queue_free()
	elif collision_shape.disabled == true and self.get_parent().name != "Inventory Content":
		collision_shape.disabled = false
	else:
		pass

