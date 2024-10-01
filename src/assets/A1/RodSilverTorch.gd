extends XRToolsPickable


@onready var dirt := $Node3D

func _associated_event_finished() -> void:
	dirt.visible = false
