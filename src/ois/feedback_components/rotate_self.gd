extends Feedback

@export var axis : Vector3 = Vector3(0, 0, 1)

func show_feedback(requirement, total_progress):
	receiver_object.transform.basis = Basis()
	receiver_object.rotate_object_local(axis, total_progress)
