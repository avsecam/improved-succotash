extends Node3D

@onready var controller := XRHelpers.get_right_controller(self.get_parent())
@onready var camera := XRHelpers.get_xr_camera(self.get_parent())
@onready var origin := XRHelpers.get_xr_origin(self.get_parent())

var has_rotated: bool = false
signal rotate_camera_called

func _physics_process(delta):
	_process_camera_rotation()

func _process_camera_rotation():
	var dz_input_action: Vector2 = XRToolsUserSettings.get_adjusted_vector2(controller, "primary")
	var camera_default_pos = camera.position
	
	if absf(dz_input_action.x) >= absf(0.3) and not has_rotated:
		#print("\n======\nCAMERA position before:"+str(camera.global_position))
		Events.player_rotate_requested.emit()
		if dz_input_action.x >= 0.3:
			origin.rotation.y += 5
		elif dz_input_action.x <= -0.3:
			origin.rotation.y -= 5
		has_rotated = true
		#print("\nCAMERA position after:"+str(camera.global_position))
		camera.position = camera_default_pos
		#print("\nCAMERA position AAAAAafter:"+str(camera.global_position))
		rotate_camera_called.emit()
		
	
	if absf(dz_input_action.x) < absf(0.3):
		has_rotated = false
	
	
