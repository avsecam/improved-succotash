extends Node


signal start_without_vr()

# TELEPORT TRIGGER
signal player_teleport_requested_trigger(new_panorama_file_path: String)
signal set_player_rotation_requested(current_rotation: Vector3, new_rotation: Vector3)
