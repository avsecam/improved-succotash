extends Node

const SAVE_DIR := "user://saves/"
const SAVE_PATH := "user://saves/save%s.dat"


func new_game(slot_num : int = 0) -> void:
	var save_path := SAVE_PATH % slot_num
	
	var data := {
		"current_location" : "",
		"quests_completed" : 0,
		"finished_events" : [],
		"ongoing_quests" : [],
		"inventory_content" : {}
	}
	
	var data_string = JSON.stringify(data)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file == null:
		if DirAccess.make_dir_recursive_absolute(SAVE_DIR) == null:
			print("making save folder")
	save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_line(data_string)
	save_file.close()
	
	var panorama_container
	if Events.current_mode == "VR":
		panorama_container = get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/PanoramaContainer")
	elif Events.current_mode == "NonVR":
		panorama_container = get_tree().get_root().get_node("Demo/NonVR/PanoramaContainer")
	
	Events.current_location = "Tut1.jpg"
	var start_scene = preload("res://src/areas/Tut1.jpg.tscn").instantiate()
	panorama_container.add_child(start_scene)


func save_game(slot_num : int = 0) -> void:
	var save_path := SAVE_PATH % slot_num
	
	var current_location : String = ""
	print(Events.current_mode)
	current_location = Events.current_location
	
	var ongoing_quests : Array = []
	var quests := get_tree().get_root().get_node("Demo/Quests")
	for quest in quests.get_children():
		ongoing_quests.push_back(quest.name)
	
	var quests_completed : int = 0
	for event in Events.finished_events:
		var start_string = event.substr(0, 5)
		if start_string.contains("Quest"):
			quests_completed += 1
	
	var inventory := get_tree().get_root().get_node("Demo/Shelf")
	var inventory_items : Dictionary
	for slot in inventory.get_children():
		if slot.is_in_group("InventorySlot_Shelf"):
			if slot.get_node("Inventory Content").get_child_count() != 0:
				inventory_items[slot.name] = slot.get_node("Inventory Content").get_child(0).get_scene_file_path()
			else:
				inventory_items[slot.name] = null
		
	var data := {
		"current_location" : current_location,
		"quests_completed" : quests_completed,
		"finished_events" : Events.finished_events,
		"ongoing_quests" : ongoing_quests,
		"inventory_content" : inventory_items
	}
	
	var data_string = JSON.stringify(data)
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file == null:
		if DirAccess.make_dir_recursive_absolute(SAVE_DIR) == null:
			print("making save folder")
	save_file = FileAccess.open(save_path, FileAccess.WRITE)
	save_file.store_line(data_string)
	save_file.close()


func load_game(slot_num : int = 0, in_game : bool = false) -> void:
	var load_path := SAVE_PATH % slot_num
	var load_file = FileAccess.open(load_path, FileAccess.READ)
	if load_file == null:
		print("Save file " + str(slot_num) + " does not exist")
		return
	
	var data : Dictionary = JSON.parse_string(load_file.get_line())
	print(data)
	
	Events.current_location = data["current_location"]
	
	Events.finished_events = data["finished_events"]
	
	var quests := get_tree().get_root().get_node("Demo/Quests")
	for quest in data["ongoing_quests"]:
		quests.add_active_quest(quest)
	
	var inventory := get_tree().get_root().get_node("Demo/Shelf")
	for slot in data["inventory_content"]:
		if data["inventory_content"][slot] != null:
			var item = load(data["inventory_content"][slot]).instantiate()
			inventory.get_node(slot).get_node("Inventory Content").add_child(item)
			inventory.get_node(slot).get_node("SnapZone").pick_up_object(item)
	
	var panorama_container
	if Events.current_mode == "VR":
		panorama_container = get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/PanoramaContainer")
	elif Events.current_mode == "NonVR":
		panorama_container = get_tree().get_root().get_node("Demo/NonVR/PanoramaContainer")
	
	var scene_path : String = "res://src/areas/" + str(data["current_location"]) + ".tscn"
	if !in_game:
		var start_scene = load(scene_path).instantiate()
		panorama_container.rotation.y = start_scene.base_rotation
		panorama_container.add_child(start_scene)
	else:
		Events.emit_signal("player_teleport_requested_trigger", data["current_location"])
	
	inventory.get_node("InventoryController").check_if_active()
	
	load_file.close()


func set_saveslot_info(slot : SaveFileSlot):
	var load_path := SAVE_PATH % slot.slot_number
	if FileAccess.file_exists(load_path):
		var load_file = FileAccess.open(load_path, FileAccess.READ)
		var data : Dictionary = JSON.parse_string(load_file.get_line())
		
		slot.current_location_label.set_text("Current Location: " + data["current_location"])
		slot.quests_finished_label.set_text("Quests Finished: " + str(data["quests_completed"])) 
		
		slot.show_savedata()
		slot.has_savedata = true
		load_file.close()
	else:
		print("Save file does not exist")
		slot.no_save_data()
		slot.has_savedata = false
	
