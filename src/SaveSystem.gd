extends Node

const SAVE_DIR := "user://saves/"
const SAVE_PATH := "user://saves/save%s.dat"

func save_game(slot_num : int = 0) -> void:
	var save_path := SAVE_PATH % slot_num
	
	var current_location : String = ""
	print(Events.current_mode)
	if Events.current_mode == "VR":
		var panorama_container := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/PanoramaContainer")
		current_location = panorama_container.get_child(0).name
	elif Events.current_mode == "NonVR":
		var panorama_container := get_tree().get_root().get_node("Demo/NonVR/PanoramaContainer")
		current_location = panorama_container.get_child(0).name
	
	var ongoing_quests : Array = []
	var quests := get_tree().get_root().get_node("Demo/Quests")
	for quest in quests.get_children():
		ongoing_quests.push_back(quest.name)
	
	var quests_completed : int = 0
	for event in Events.finished_events:
		if event.contains("Quest"):
			quests_completed += 1
	
	print(current_location)
	print(ongoing_quests)
	print(quests_completed)
	
	var inventory := get_tree().get_root().get_node("Demo/Shelf")
	
	var data := {
		"current_location" : current_location,
		"quests_completed" : quests_completed,
		"finished_events" : Events.finished_events,
		"ongoing_quests" : ongoing_quests,
		"inventory_content" : ""
	}
	
	var data_string = JSON.stringify(data)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file == null:
		if DirAccess.make_dir_recursive_absolute(SAVE_DIR) == null:
			print("making save folder")
	save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_line(data_string)
	save_file.close()


func load_game(slot_num : int = 0) -> void:
	var load_path := SAVE_PATH % slot_num
	var load_file = FileAccess.open(load_path, FileAccess.READ)
	if load_file == null:
		print("Save file " + str(slot_num) + " does not exist")
		return
	
	var data : Dictionary = JSON.parse_string(load_file.get_line())
	print(data)
	
	Events.finished_events = data["finished_events"]
	
	var quests := get_tree().get_root().get_node("Demo/Quests")
	for quest in data["ongoing_quests"]:
		quests.add_active_quest(quest)
