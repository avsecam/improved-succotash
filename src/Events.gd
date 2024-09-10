extends Node

@onready var camera = $"../Demo/XRPlayer/XROrigin3D/XRCamera3D"

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

#DIALOGUE SIGNALS
signal update_npc_name(npcx: String)
signal update_npc_line(line: String)

#EVENT FLAGS
var current_bgm

var event_library : Dictionary = {}
var quest_library : Dictionary = {}
var ongoing_events : Array = []
var finished_events : Array = []

func _ready():
	event_library = load_event_data("res://src/ems/eventsystem_new/EventLibrary.json")
	print(event_library)
	print(camera.name)

func load_event_data(file_location: String) -> Dictionary:
	var output_dictionary : Dictionary = {}
	
	var json_as_text = FileAccess.get_file_as_string(file_location)
	var json_as_array = JSON.parse_string(json_as_text)
	
	for key in json_as_array:
		output_dictionary[key["Event_Name"]] = {
			"Event_Category" : key["Event_Category"],
			"Oneshot" : key["Oneshot"],
			"Event_Prerequisites" : key["Event_Prerequisites"],
			"Event_Completion_Flags" : key["Event_Completion_Flags"],
			"Event_Audio" : key["Event_Audio"],
			"Loop_Audio" : key["Loop_Audio"],
			"Loop_Interval" : key["Loop_Interval"]
		}
	return output_dictionary
	

func load_quest_data(file_location: String) -> Dictionary:
	var output_dictionary : Dictionary = {}
	
	var json_as_text = FileAccess.get_file_as_string(file_location)
	var json_as_array = JSON.parse_string(json_as_text)
	
	for key in json_as_array:
		output_dictionary[key["Quest_Name"]] = {
			"Quest_Description" : key["Quest_Description"],
			"Quest_Completion_Requirements" : key["Quest_Completion_Requirements"]
		}
	return output_dictionary
