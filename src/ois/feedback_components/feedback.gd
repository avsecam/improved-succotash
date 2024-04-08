extends Node3D
class_name Feedback

var receiver_object

# Called when the node enters the scene tree for the first time.
func _ready():
	receiver_object = get_parent()

func show_feedback(requirement, total_progress):
	pass
