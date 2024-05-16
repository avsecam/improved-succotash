extends Node3D
class_name StateBehavior

func on_enter_state():
	pass

func on_exit_state():
	pass

func manage_signal(is_entering):
	if is_entering:
		on_enter_state()
	else:
		on_exit_state()
