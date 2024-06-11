extends Node3D

@onready var panorama_container = $NonVR/PanoramaContainer

func _ready():
	$FDLoadArea.visible = false
	$FDAddItem.visible = false
	_on_check_button_toggled(false)

func _on_btn_load_area_pressed():
	$FDLoadArea.visible = true

func _on_fd_load_area_file_selected(path):
	panorama_container.set_scene(path)

func _on_btn_add_object_pressed():
	$FDAddItem.visible = true

func _on_fd_add_item_file_selected(path):
	pass # Replace with function body.

func _on_check_button_toggled(toggled_on):
	PhysicsServer3D.set_active(toggled_on)
