extends Node3D
@onready var numpad_view = $StaticUIContainer/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView

func _on_numpad_1_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		numpad_view.text = "[center]1"
		print(1)


func _on_numpad_2_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(2)


func _on_numpad_3_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(3)


func _on_numpad_4_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(4)


func _on_numpad_5_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(5)


func _on_numpad_6_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(6)


func _on_numpad_7_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(7)


func _on_numpad_8_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(8)


func _on_numpad_9_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print(9)
