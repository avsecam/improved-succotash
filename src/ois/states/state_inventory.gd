extends OISState

@onready var state_manager = get_parent()

func add_to_inventory():
	state_manager.set_state(self)
