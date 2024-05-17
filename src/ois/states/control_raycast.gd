extends StateBehavior
class_name SBRaycast

@export var raycast : Node3D
@export var is_enabled : bool = false

func on_enter_state():
	raycast.enable_raycast(is_enabled)
