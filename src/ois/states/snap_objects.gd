extends StateBehavior

@onready var state_manager : StateManager = get_parent().get_parent()
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
		var snap_node = receiver_object.get_node_or_null("SnapPos")
		if snap_node != null:
			actor_object.global_position = snap_node.global_position + (actor_object.global_position - snap_pos.global_position)

func on_exit_state():
	receiver_object = null
	set_process(false)
