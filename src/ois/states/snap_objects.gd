extends StateBehavior
class_name SBSnap

@onready var state_manager : StateManager = get_parent()
@onready var actor_object = state_manager.get_parent()
@export var snap_pos : Node3D
var receiver_object

func _ready():
	set_process(false)

func on_enter_state():
	set_process(true)

func _process(delta):
	if state_manager.receiver_object != null:
		receiver_object = state_manager.receiver_object
		actor_object.global_position = receiver_object.get_node("SnapPos").global_position + (actor_object.global_position - snap_pos.global_position)

func on_exit_state():
	receiver_object = null
	set_process(false)
