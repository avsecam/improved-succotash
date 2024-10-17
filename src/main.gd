extends Node3D

var xr_interface: XRInterface
@onready var static_ui_container := $StaticUIContainer
@onready var main_menu_container := $MainMenu
@onready var main_menu_controller := $MainMenuController

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully.")
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		Events.start_with_vr.emit()
		static_ui_container.initialize_static_ui_container("VR")
		main_menu_container.initialize_main_menu_container("VR")
		main_menu_controller.initialize_main_menu_controller("VR")
		
		Events.current_mode = "VR"
		
		#SaveSystem.load_game(1)
		
	else:
		ProjectSettings.set_setting("xr/openxr/enabled", false)
		ProjectSettings.set_setting("xr/shaders/enabled", false)
		print("OpenXR not initialized, starting in non-VR mode.")
		Events.start_without_vr.emit()
		static_ui_container.initialize_static_ui_container("NonVR")
		main_menu_container.initialize_main_menu_container("NonVR")
		main_menu_controller.initialize_main_menu_controller("NonVR")
		Events.current_mode = "NonVR"
	
	get_tree().paused = true




func _on_right_hand_button_pressed(name):
	print("BUTTON PRESSED: "+name)
