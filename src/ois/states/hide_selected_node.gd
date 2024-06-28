extends StateBehavior

@export var node : Node3D

func on_enter_state():
	node.visible = false
	
func on_exit_state():
	node.visible = true
