@tool
extends XRToolsPickable

@onready var main_mesh = $MainMesh
@onready var replacement_mesh = $ReplacementMesh

@onready var state_manager = get_node_or_null("StateManager")

func _ready():
	super()
	toggle_replacement_mesh()

func toggle_replacement_mesh() -> void:
	print(self.name+" | Toggled replacement mesh OFF.")	
	main_mesh.visible = true
	replacement_mesh.visible = false
	
func toggle_main_mesh() -> void:
	print(self.name+" | Toggled main mesh OFF.")	
	main_mesh.visible = false
	replacement_mesh.visible = true
	if state_manager != null:
		state_manager.add_to_inventory()

func _get_configuration_warnings():
	var warnings = []
	
	var has_grab_point = false
	for i in get_children():
		if i is XRToolsGrabPointHand:
			has_grab_point = true
			break
	
	if !has_grab_point:
		warnings.append("Add GrabPointHand")

	# Returning an empty array means "no warning".
	return warnings
