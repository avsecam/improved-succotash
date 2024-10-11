extends Feedback

@export var pole_visible : Node3D


func _process(delta):
	if pole_visible.visible:
		pole_visible.rotation_degrees.x += 10 * delta
