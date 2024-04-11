extends Node3D
class_name StateManager

@export var receiver_group : String = ""
@export var current_state : OISState
@export var debug : bool = true

var receiver_object
@onready var actor = get_parent()

func _ready():
	set_state(current_state)

func set_state(state : OISState):
	if (current_state != null):
		current_state.exit_state.emit()
	current_state = state
	current_state.enter_state.emit()
