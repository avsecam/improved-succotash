extends StateBehavior
class_name SBSnap

@onready var state_manager : StateManager = get_parent()
@onready var actor_object = state_manager.get_parent()

var receiver_object

func _ready():
	set_process(false)

func on_enter_state():
	set_process(true)

func _process(delta):
	if state_manager.receiver_object != null:
		receiver_object = state_manager.receiver_object
		if receiver_object.has_node("SnapPos"):
			actor_object.global_position = receiver_object.get_node("SnapPos").global_position + (actor_object.global_position - global_position)
		else:
			actor_object.global_position = receiver_object.global_position + (actor_object.global_position - global_position)
	
func on_exit_state():
	receiver_object = null
	set_process(false)
