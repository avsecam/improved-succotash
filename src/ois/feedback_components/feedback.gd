extends Node3D
class_name Feedback

var receiver_object

@export_subgroup("Feedback Timing")
@export var action_start : bool = false
@export var action_during : bool = true
@export var action_end : bool = false
@export var action_completed : bool = false # when action requirements are met

# Called when the node enters the scene tree for the first time.
func _ready():
	receiver_object = get_parent()

func show_feedback(requirement, total_progress):
	pass
