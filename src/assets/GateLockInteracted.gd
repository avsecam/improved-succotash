extends "res://src/ois/feedback_components/play_animation.gd"



func _on_front_gate_action_completed(requirement, total_progress):
	AudioHandler.play_sfx("Tut_Gate_Open", $"../AudioStreamPlayer3D")


func _on_front_gate_action_in_progress(requirement, total_progress):
	if total_progress < 0:
		get_parent().total_progress = 0
