extends Node


signal start_with_vr()
signal start_without_vr()

# TELEPORT TRIGGER
signal player_teleport_requested_trigger(new_panorama_file_path: String)
signal set_player_rotation_requested(current_rotation: Vector3, new_rotation: Vector3)


# NON VR SIGNALS FOR TESTING WITHOUT A HEADSET
signal non_vr_teleporter_hovered(teleporter: Teleporter)
signal non_vr_no_teleporter_hovered()
signal non_vr_teleporter_clicked(to: String) # filename of scene to teleport to
