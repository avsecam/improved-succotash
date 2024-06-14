extends Node3D

func _ready():
	# Make the gizmo disabled by default.
	print("REINITIALIZE")
	update(false);

func update(is_active):
	# Based on is_active, change the visibility of the select gizmo.
	visible = is_active;

func axis_set(new_axis):
	# Because the select gizmo has no axes, we can just ignore this function!
	pass
