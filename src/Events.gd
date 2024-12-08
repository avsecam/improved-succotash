extends Node

@onready var camera = $"../Demo/XRPlayer/XROrigin3D/XRCamera3D"

signal start_with_vr()
signal start_without_vr()

# TELEPORT TRIGGER
signal no_teleporter_hovered()
signal teleporter_hovered(teleporter: Teleporter)
signal player_teleport_requested_trigger(new_level_filepath: String, special_state : bool)
signal player_rotate_requested()
signal set_player_rotation_requested(current_rotation: Vector3, new_rotation: Vector3)


# NON VR SIGNALS FOR TESTING WITHOUT A HEADSET
signal non_vr_teleporter_hovered(teleporter: Teleporter)
signal non_vr_no_teleporter_hovered()
signal non_vr_teleporter_clicked(to: String) # filename of scene to teleport to

#DIALOGUE SIGNALS
signal update_dialogue_box(name: String, dialogue: String)


var current_mode : String


#EVENT FLAGS
var current_bgm
var current_location 

var event_library : Dictionary = {}
var quest_library : Dictionary = {}
var ongoing_events : Array = []
var finished_events : Array = []
var cat_tray_content : Dictionary = {"Slot" : null, "Slot3" : null, "Slot2" : null}

var locked_teleporters : Dictionary = {
	"Tut2_jpg" : "WaypointToTut2_Open",
	"Tut3_jpg" : "WaypointToTut3_Open",
	"Img2024032114013000113PureShot_jpg" : "WaypointToGate_Open",
	"FrontClosedDoors(2)_jpg" : "WaypointToA_Open",
	"FrontRight_jpg" : "WaypointToAQuest_Open",
	"Middle4_jpg" : "WaypointToMid4_Open",
	"Img2023111609464900044_jpg" : "WaypointToMid8_Open",
	"Back0_jpg" : "WaypointToB_Open",
	"Left2_jpg" : "QuestPlaceAllTheCatIcons_Done",
	"RightStairs1_jpg" : "WaypointUpStairs_Open",
	"Back2_jpg" : "DialoguePaintingsReminder_Done",
	"2Right3_jpg": "ActionCoinInFrame_Done"
}

func _ready():
	event_library = load_event_data("res://src/ems/eventsystem_new/EventLibrary.json")
	quest_library = load_quest_data("res://src/ems/eventsystem_new/QuestLibrary.json")
	#print(event_library)
	#print(camera.name)

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
			"Loop_Interval" : key["Loop_Interval"],
			"Event_Text" : key["Event_Text"],
			"Play_Success_SFX" : key["Play_Success_SFX"]
		}
	return output_dictionary
	

func load_quest_data(file_location: String) -> Dictionary:
	var output_dictionary : Dictionary = {}
	
	var json_as_text = FileAccess.get_file_as_string(file_location)
	var json_as_array = JSON.parse_string(json_as_text)
	
	for key in json_as_array:
		output_dictionary[key["Quest_Name"]] = {
			"Quest_Description" : key["Quest_Description"],
			"Quest_Completion_Requirements" : key["Quest_Completion_Requirements"],
			"Quest_Completion_Tracker" : key ["Quest_Completion_Tracker"],
			"Quest_Completion_Flags" : key ["Quest_Completion_Flags"]
		}
	return output_dictionary
	
# This script contains all the signals that are used to communicate between the different parts of the application.

# Teleport Author
signal teleport_node_selected(node: TeleportNode)
signal teleport_node_drag_started(node: TeleportNode)
signal teleport_node_add_requested(node: TeleportNode, internal_name: String)
signal teleport_node_delete_requested(node: TeleportNode)
signal teleport_node_edit_requested(node: TeleportNode)
signal teleport_node_edit_confirm_requested(node: TeleportNode)
signal teleport_node_connection_add_requested(to: TeleportNode)

signal teleport_node_enter_requested(node: TeleportNode)
signal teleport_node_exit_requested(node: TeleportNode)
signal teleporter_add_requested(node: TeleportNode, pos: Vector3, rot: Vector3)
signal teleporter_add_finished(node: TeleportNode, teleporter: TeleporterAuth, pos: Vector3, rot: Vector3)

signal connection_entry_select_requested(entry: ConnectionEntry)
signal connection_entry_delete_requested(entry: ConnectionEntry)

# Event Author
signal event_flags_toggle_requested()
signal locks_toggle_requested(teleporter: TeleporterAuth)

signal trigger_add_requested(trigger_name: String)
signal trigger_add_confirmed(trigger_name: String)
signal trigger_delete_requested(trigger_name: String)
signal trigger_delete_confirmed(trigger_name: String)
signal trigger_toggle_requested(trigger_name: String)
signal trigger_set_requested(trigger_name: String, value: bool)

signal trigger_toggle_connection_requested(trigger_name: String, teleporter: TeleporterAuth)

# Demo
signal demo_requested(start_node: TeleportNode)
signal demo_exit_requested()

signal teleport_requested(to: TeleportNode)

# Common
signal switch_requested()

signal export_requested()
signal save_requested()
signal save_finished()
signal load_requested(file_path: String)
