extends Node3D

var xr_interface: XRInterface
@onready var static_ui_container := $StaticUIContainer

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		Events.start_with_vr.emit()
		static_ui_container.initialize_static_ui_container("VR")
		Events.current_mode = "VR"
		
	else:
		ProjectSettings.set_setting("xr/openxr/enabled", false)
		ProjectSettings.set_setting("xr/shaders/enabled", false)
		print("OpenXR not initialized, starting in non-VR mode.")
		Events.start_without_vr.emit()
		static_ui_container.initialize_static_ui_container("NonVR")
		Events.current_mode = "NonVR"
