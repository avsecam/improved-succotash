extends StateBehavior

@onready var state_manager : StateManager = get_parent().get_parent()
var receiver_object
@export var rate : float = 1

func _ready():
	set_process(false)

func on_enter_state():
	if state_manager.receiver_object != null:
		print(state_manager.current_state.name + ": " + state_manager.receiver_object.name)
		receiver_object = state_manager.receiver_object
		receiver_object.start_action_check(state_manager, rate)

func on_exit_state():
	if receiver_object != null:
		receiver_object.start_action_check(null, 0)
	set_process(false)
