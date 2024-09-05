extends Event

@onready var mesh = $"../../Cat/MeshInstance3D2"
const white_hover = preload("res://src/ois/xx_demo_objects/white.tres")

func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()
	
func _on_cat_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.ENTERED:
		print("hovering at cat")
		mesh.material_override = white_hover

	elif event.event_type == XRToolsPointerEvent.Type.EXITED:
		# When the pointer exits, no more material
		print("no longer hovering at cat")
		mesh.material_override = null

	elif event.event_type == XRToolsPointerEvent.Type.PRESSED:
		# You can still handle pressing if needed
		print("cat petted")
		mesh.material_override = null
		close_event()
