extends Feedback

@export var mesh : MeshInstance3D
@export var surface_index : int = 0
var material

func _ready():
	super()
	material = mesh.get_surface_override_material(surface_index).duplicate()
	
func show_feedback(requirement, total_progress):
	var percentage_done = total_progress/requirement
	material.albedo_color.a = 1-percentage_done
	mesh.set_surface_override_material(surface_index, material)
