extends Node3D


@onready var camera = get_parent()
@onready var object_distance : float = 0.8


func _physics_process(delta):
	
	var position_x_rotate = object_distance * cos(camera.global_rotation.y - self.get_parent().get_parent().global_rotation.y)
	var position_z_rotate = object_distance * sin(camera.global_rotation.y - self.get_parent().get_parent().global_rotation.y)
	var position_ui_offset = Vector3(-position_z_rotate,0.25,-position_x_rotate)
	
	#self.global_transform.origin = self.global_transform.origin.lerp(camera.global_transform.origin + position_ui_offset, 2*delta)
	self.global_transform.origin = camera.global_transform.origin + position_ui_offset
