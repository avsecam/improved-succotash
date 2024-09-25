extends Node3D

var xr_interface: XRInterface
@onready var dialogue_container := $"Dialogue Container"

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		Events.start_with_vr.emit()
		dialogue_container.initialize_dialogue_container("VR")
	else:
		ProjectSettings.set_setting("xr/openxr/enabled", false)
		ProjectSettings.set_setting("xr/shaders/enabled", false)
		print("OpenXR not initialized, starting in non-VR mode.")
		Events.start_without_vr.emit()
		dialogue_container.initialize_dialogue_container("NonVR")
