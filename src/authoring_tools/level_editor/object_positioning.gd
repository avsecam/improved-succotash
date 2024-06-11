extends Node3D

@onready var gizmo = $Editor_Controller
@onready var panorama_container = $NonVR/PanoramaContainer
var current_area : Panorama = null

@onready var new_obj_initial_pos = $Editor_Controller/Editor_Camera_Controller/View_Camera/NewObjInitialPos

func _ready():
	$FDLoadArea.visible = false
	$FDAddItem.visible = false
	_on_check_button_toggled(false)
	gizmo.set_gizmo_scale(0.1)
	if panorama_container.get_child_count() > 0:
		current_area = panorama_container.get_child(0)

func _on_btn_load_area_pressed():
	$FDLoadArea.visible = true

func _on_fd_load_area_file_selected(path):
	current_area = panorama_container.set_scene(path)

func _on_btn_add_object_pressed():
	$FDAddItem.visible = true

func _on_fd_add_item_file_selected(path):
	if current_area != null:
		var new_obj = load(path).instantiate()
		current_area.add_child(new_obj)
		new_obj.owner = current_area
		new_obj.global_position = new_obj_initial_pos.global_position

func _on_check_button_toggled(toggled_on):
	PhysicsServer3D.set_active(toggled_on)
