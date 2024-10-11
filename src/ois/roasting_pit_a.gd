extends StaticBody3D

@export var pole_visible : Node3D
var time : float

func _physics_process(delta):
	if pole_visible.visible:
		time += delta
		pole_visible.rotation_degrees.x += 30 * time
		pole_visible.rotation_degrees.y = 180
		pole_visible.rotation_degrees.z = 90
		pole_visible.position.x = 0
		pole_visible.position.y = 0.5
		pole_visible.position.z = 0
