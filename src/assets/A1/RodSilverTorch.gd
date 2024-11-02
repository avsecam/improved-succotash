extends XRToolsPickable


@onready var dirt := $Node3D
@onready var progress_view = $"Progress View"

func _associated_event_finished() -> void:
	dirt.visible = false
	progress_view.progress_complete_anim()
