extends Node3D
@onready var numpad_view = $StaticUIContainer/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@export var password = ["–","–","–"]

func notepad_inputter(num):
	if password[0] == "–":
		password[0] = num
	elif password[1] == "–":
		password[1] = num
	elif password[2] == "–":
		password[2] = num
	else:
		password[0] = num
		password[1] = "–"
		password[2] = "–"
	var format_string = "[center]%s %s %s"
	numpad_view.text = format_string % [str(password[0]), str(password[1]), str(password[2])]

func _on_numpad_1_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("1")

func _on_numpad_2_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("2")

func _on_numpad_3_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("3")

func _on_numpad_4_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("4")

func _on_numpad_5_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("5")

func _on_numpad_6_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("6")

func _on_numpad_7_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("7")

func _on_numpad_8_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("8")

func _on_numpad_9_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		notepad_inputter("9")
