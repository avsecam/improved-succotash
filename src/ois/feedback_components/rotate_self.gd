extends Feedback

@export var axis : Vector3 = Vector3(0, 0, 1)

var init_transform

func _ready():
	super()
	init_transform = receiver_object.transform.basis
	print(init_transform)
	
func show_feedback(requirement, total_progress):
	receiver_object.transform.basis = init_transform
	receiver_object.rotate_object_local(axis, total_progress)
