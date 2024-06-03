extends MarginContainer

@onready var editable_object = $StaticBody3D
@onready var action_comp_container = $ScrollContainer/Main/ActionCompContainer

var action_comp_settings_scn = preload("res://src/ois/authoring_tool/action_comp_settings/action_comp_settings.tscn")
var action_comp_settings

func set_editable_object(obj):
	editable_object = obj

func _on_btn_add_action_comp_pressed():
	$FDSelectActionComp.visible = true

# assign action component to editable object
# create corresponding action component settings gui
func _on_fd_select_action_comp_file_selected(path):
	if action_comp_container.get_child(0) != null:
		action_comp_container.get_child(0).queue_free()
	action_comp_settings = action_comp_settings_scn.instantiate()
	action_comp_container.add_child(action_comp_settings)
	
	editable_object.set_script(load(path))
	var action_comp_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	action_comp_settings.set_action_component(editable_object, action_comp_name)	
