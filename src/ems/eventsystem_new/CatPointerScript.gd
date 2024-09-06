extends XRToolsInteractableBody

@onready var mesh = $MeshInstance3D2
const white_hover = preload("res://src/ois/xx_demo_objects/white.tres")
signal pet_event_done

func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		mesh.material_override = white_hover
	elif event.event_type == XRToolsPointerEvent.Type.EXITED:
		mesh.material_override = null
	elif event.event_type == XRToolsPointerEvent.Type.PRESSED:
		mesh.material_override = null
		emit_signal("pet_event_done")
