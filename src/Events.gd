extends Node


signal start_with_vr()
signal start_without_vr()

# TELEPORT TRIGGER
signal no_teleporter_hovered()
signal teleporter_hovered(teleporter: Teleporter)
signal player_teleport_requested_trigger(new_level_filepath: String)
signal player_rotate_requested()
signal set_player_rotation_requested(current_rotation: Vector3, new_rotation: Vector3)


# NON VR SIGNALS FOR TESTING WITHOUT A HEADSET
signal non_vr_teleporter_hovered(teleporter: Teleporter)
signal non_vr_no_teleporter_hovered()
signal non_vr_teleporter_clicked(to: String) # filename of scene to teleport to

#EVENT FLAGS
var look_at_me = false
var pick_up_key = false
var earth_spirit = false
var open_gate = false
var pet_cat = false
var get_picture = false
var quest_start = false
var talk_about_calandra = false
var fire_spirit_help = false
