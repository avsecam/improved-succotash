extends "res://src/ois/feedback_components/play_animation.gd"



func _on_front_gate_action_completed(requirement, total_progress):
	AudioHandler.play_sfx("Tut_Gate_Open", $"../AudioStreamPlayer3D")
