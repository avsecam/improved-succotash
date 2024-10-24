extends Node3D

@onready var gizmo = $Editor_Controller
@onready var camera_controller = $Editor_Controller/Editor_Camera_Controller
@onready var panorama_container = $NonVR/PanoramaContainer
var current_area : Panorama = null
var current_area_path : String

@onready var new_obj_initial_pos = $Editor_Controller/Editor_Camera_Controller/View_Camera/NewObjInitialPos
@onready var notification_panel = $NotificationPanel

func _ready():
	$FDLoadArea.visible = false
	$FDAddItem.visible = false
	_on_btn_gravity_on_toggled(false)
	_on_btn_view_floor_toggled(false)
	_on_btn_fixed_view_toggled(true)
	gizmo.set_gizmo_scale(0.1)
	
	if panorama_container.get_child_count() > 0:
		current_area = panorama_container.get_child(0)
		current_area_path = current_area.scene_file_path
		print(current_area_path)

func _on_btn_load_area_pressed():
	$FDLoadArea.visible = true

func _on_fd_load_area_file_selected(path):
	$Editor_Controller/Editor_Viewport.physics_object_selected(null)
	current_area = panorama_container.set_scene(path)
	if current_area != null:
		current_area_path = path

func _on_btn_add_object_pressed():
	$FDAddItem.visible = true

func _on_fd_add_item_file_selected(path):
	if current_area != null:
		var new_obj = load(path).instantiate()
		current_area.add_child(new_obj)
		new_obj.owner = current_area
		new_obj.global_position = new_obj_initial_pos.global_position

func _on_btn_overwrite_save_pressed():
	$CDOverwriteSave.visible = true
	$CDOverwriteSave/Label.text = "You will be overwriting %s. Are you sure you with to proceed?" % current_area_path

func _on_cd_overwrite_save_confirmed():
	$Editor_Controller/Editor_Viewport.physics_object_selected(null)
	var scene = PackedScene.new()
	scene.pack(current_area)
	var error = ResourceSaver.save(scene, current_area_path)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")
		notification_panel.show_notification("An error occurred while saving the scene to disk.")
	else:
		print("Saved area to %s" % current_area_path)
		notification_panel.show_notification("Saved area to %s" % current_area_path)

func _on_btn_save_as_pressed():
	$FDSaveArea.visible = true

func _on_fd_save_area_file_selected(path):
	$Editor_Controller/Editor_Viewport.physics_object_selected(null)
	var scene = PackedScene.new()
	scene.pack(current_area)
	var error = ResourceSaver.save(scene, path)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")
		notification_panel.show_notification("An error occurred while saving the scene to disk.")
	else:
		print("Saved object to %s" % path)
		notification_panel.show_notification("Saved object to %s" % path)

func _on_btn_fixed_view_toggled(toggled_on):
	camera_controller.is_panorama_camera = toggled_on

func _on_btn_gravity_on_toggled(toggled_on):
	PhysicsServer3D.set_active(toggled_on)

func _on_btn_view_floor_toggled(toggled_on):
	$Floor/MeshInstance3D.visible = toggled_on


func _on_btn_delete_obj_pressed():
	$Editor_Controller/Editor_Viewport.selected_physics_object.queue_free()
	$Editor_Controller/Editor_Viewport.physics_object_selected(null)
