extends Node

@export var marker1checked:bool
@export var marker2checked:bool
@export var marker3checked:bool
var lookaround_done:bool
signal all_markers_seen

func _on_marker_1_screen_entered():
	if not marker1checked:
		marker1checked = true
		print("marker 1 done")
		if marker1checked and marker2checked and marker3checked and not lookaround_done:
			all_markers_seen.emit()


func _on_marker_2_screen_entered():
	if not marker2checked:
		marker2checked = true
		print("marker 2 done")
		if marker1checked and marker2checked and marker3checked and not lookaround_done:
			all_markers_seen.emit()


func _on_marker_3_screen_entered():
	if not marker3checked:
		marker3checked = true
		print("marker 3 done")
		if marker1checked and marker2checked and marker3checked and not lookaround_done:
			all_markers_seen.emit()
