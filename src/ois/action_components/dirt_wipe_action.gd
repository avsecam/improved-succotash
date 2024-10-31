extends WipeAction
@onready var main_mesh = $MainMesh
@onready var progress_view = $"Progress View"

func _associated_event_done() -> void:
	main_mesh.visible = false
	progress_view.progress_complete_anim()
