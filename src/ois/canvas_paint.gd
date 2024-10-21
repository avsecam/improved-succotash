extends XRToolsPickable

@onready var main_mesh = $MainMesh

signal finish_paint

func _ready():
	self.enabled = false


func _on_feedback_finish_paint_feedback():
	finish_paint.emit()
	self.enabled = true


func _on_picked_up(pickable):
	main_mesh.scale = Vector3(0.185,0.185,0.185)

	
