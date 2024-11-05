extends Node3D
@onready var numpad_view = $StaticUIContainer/Viewport2Din3D/Viewport/NumPadUI/VBoxContainer/ColorRect/NumpadView
@export var password = ["–","–","–"]
@export var passkey = ["3","6","7"]
signal correct_password_inputted

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
	if arrays_have_same_content(password, passkey): correct_password_inputted.emit()

func arrays_have_same_content(array1, array2):
	if array1.size() != array2.size(): return false
	for item in array1:
		if !array2.has(item): return false
		if array1.count(item) != array2.count(item): return false
	return true

func _on_numpad_1_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("1")

func _on_numpad_2_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("2")

func _on_numpad_3_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("3")

func _on_numpad_4_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("4")

func _on_numpad_5_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("5")

func _on_numpad_6_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("6")

func _on_numpad_7_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("7")

func _on_numpad_8_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("8")

func _on_numpad_9_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		AudioHandler.play_sfx("UI_Confirm", null)
		notepad_inputter("9")
