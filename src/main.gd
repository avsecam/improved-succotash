extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully.")
		ProjectSettings.set_setting("xr/openxr/enabled", true)
		ProjectSettings.set_setting("xr/shaders/enabled", true)
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, starting in non-VR mode.")
		Events.start_without_vr.emit()
		
		# Replicate VR environment with a 3D camera and panorama
		var panorama = preload("res://src/teleportation/Panorama.tscn").instantiate()
		panorama.name = "Panorama"
		panorama.data_filename = "Outside0.jpg.json"
		add_child(panorama)
		
		var non_vr_camera = Camera3D.new()
		non_vr_camera.name = "Non VR Camera"
		add_child(non_vr_camera)
		non_vr_camera.make_current()

