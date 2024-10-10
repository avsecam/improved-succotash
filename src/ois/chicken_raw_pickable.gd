extends XRToolsPickable

@onready var state_manager = $StateManager

func _process(delta):
	if is_picked_up():
		state_manager.disabled = false
	else:
		state_manager.disabled = true
