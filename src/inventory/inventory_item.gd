extends XRToolsPickable

@onready var main_mesh = $MainMesh
@onready var replacement_mesh = $ReplacementMesh

func toggle_replacement_mesh() -> void:
	print(self.name+" | Toggled replacement mesh OFF.")	
	main_mesh.visible = true
	replacement_mesh.visible = false
	
func toggle_main_mesh() -> void:
	print(self.name+" | Toggled main mesh OFF.")	
	main_mesh.visible = false
	replacement_mesh.visible = true
