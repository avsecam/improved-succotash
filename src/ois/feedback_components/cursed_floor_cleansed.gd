extends Feedback

@export var cursed_floor_mesh: Node3D

signal cursed_floor_purified

func show_feedback(requirement, total_progress):
	cursed_floor_mesh.visible = false
	self.get_parent().queue_free()
	print("UMAK")
	cursed_floor_purified.emit()
	
	if (total_progress >= requirement):
		print("Floor is purified")
