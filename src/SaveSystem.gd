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
	
	var quest_ui := get_tree().get_root().get_node("Demo/StaticUIContainer/Viewport2Din3D/Viewport/StaticUI/QuestTrackerUI")
	
	quest_ui.clear_quests()
	
	var quests := get_tree().get_root().get_node("Demo/Quests")
	
	for quest in quests.get_children():
		quest.free()
	
	for quest in data["ongoing_quests"]:
		quests.add_active_quest(quest)
	
	var inventory := get_tree().get_root().get_node("Demo/Shelf")
	
	for slot in inventory.get_children():
		if slot.is_in_group("InventorySlot_Shelf"):
			if slot.get_node("Inventory Content").get_child_count() != 0:
				for child in slot.get_node("Inventory Content").get_children():
					child.free()
				
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
		Events.emit_signal("player_teleport_requested_trigger", data["current_location"], true)
	
	inventory.get_node("InventoryController").check_if_active()
	
	load_file.close()


func set_saveslot_info(slot : SaveFileSlot):
	var load_path := SAVE_PATH % slot.slot_number
	if FileAccess.file_exists(load_path):
		var load_file = FileAccess.open(load_path, FileAccess.READ)
		var data : Dictionary = JSON.parse_string(load_file.get_line())
		
		var location_name := {
		"special_room_forge" : "Special Room - Forge",
		"special_room_kitchen" : "Special Room - Kitchen",
		"special_room_powerplant_room" : "Special Room - Powerplant Room",
		"special_room_weapons" : "Special Room - Weapons Room",
		"Img2023111609464900044.jpg" : "First Floor - Middle 8 (Windows)",
		"Middle7.jpg" : "First Floor - Middle 7 (Carossa)",
		"Middle6.jpg" : "First Floor - Middle 6",
		"Middle5.jpg" : "First Floor - Middle 5 (Lockbox)",
		"Middle4.jpg" : "First Floor - Middle 4 (Tabernacle)",
		"Middle3.jpg" : "First Floor - Middle 3 (Last Supper)",
		"Middle2.jpg" : "First Floor - Middle 2",
		"Middle1.jpg" : "First Floor - Middle 1",
		"Middle0.jpg" : "First Floor - Middle Ingress",
		"FrontRight.jpg" : "First Floor - Near Entrance, Left Side",
		"FrontClosedDoors(2).jpg" : "First Floor - Museum Entrance",
		"Left00.jpg" : "First Floor - Left 0 (Pillar)",
		"Left1.jpg" : "First Floor - Left 1",
		"Left2.jpg" : "First Floor - Left 2",
		"Left3.jpg" : "First Floor - Left 3",
		"Left4.jpg" : "First Floor - Left 4",
		"Left5.jpg" : "First Floor - Left 5 (Amphora)",
		"Left7.jpg" : "First Floor - Left 6",
		"Left10Cheetah.jpg" : "First Floor - Left 7 (Cheetah)",
		"Left11.jpg" : "First Floor - Left 8 (Cat Icons)",
		"Back0.jpg" : "First Floor - Back Ingress",
		"Back1.jpg" : "First Floor - Back 1",
		"Back2.jpg" : "First Floor - Back 2 (Painting)",
		"Rights0.jpg" : "First Floor - Right 0 (Kitchen Portal)",
		"Rights1.jpg" : "First Floor - Right 1 (Portraits)",
		"Rights2.jpg" : "First Floor - Right 2",
		"Right1.jpg" : "First Floor - Right 3 (Powerplant Portal)",
		"Right3.jpg" : "First Floor - Right 4",
		"Right4.jpg" : "First Floor - Right 5",
		"Right5.jpg" : "First Floor - Right 6",
		"RightStairs0.jpg" : "First Floor - Stairs Entrance (Number Sequence)",
		"RightStairs1.jpg" : "Stairs to Second Floor",
		"2Right0.jpg" : "Second Floor - Right Ingress (Black Cat)",
		"2Right1.jpg" : "Second Floor - Right 1 (Forge Portal)",
		"2Right3.jpg" : "Second Floor - Right 2",
		"2Right4.jpg" : "Second Floor - Right 3",
		"2Right5.jpg" : "Second Floor - Right 4",
		"Img2023111613065000077.jpg" : "Second Floor - Right 5",
		"2Right6.jpg" : "Second Floor - Right 6",
		"2Right7.jpg" : "Second Floor - Right 7",
		"2Right8.jpg" : "Second Floor - Right 8 (Ceramics)",
		"2Right10.jpg" : "Second Floor - Right 9",
		"2Right9.jpg" : "Second Floor - Right 10",
		"2Back0.jpg" : "Second Floor - Back Ingress",
		"2Back1.jpg" : "Second Floor - Back 1 (Documents)",
		"2Back2.jpg" : "Second Floor - Left Ingress",
		"2Left0.jpg" : "Second Floor - Left 1 (Ship)",
		"2Left1.jpg" : "Second Floor - Left 2",
		"2Left2.jpg" : "Second Floor - Left 3",
		"2Left3.jpg" : "Second Floor - Left 4",
		"2Left4Puli.jpg" : "Second Floor - Left 5",
		"2Left5.jpg" : "Second Floor - Left 6",
		"2Left6.jpg" : "Second Floor - Left 7A (Clothes)",
		"2Left8.jpg" : "Second Floor - Left 7",
		"2Left7.jpg" : "Second Floor - Left 7B (Clothes 2)",
		"2Left9.jpg" : "Second Floor - Left 7C (Clothes 3)",
		"2Left10.jpg" : "Second Floor - Left 8",
		"2Left11.jpg" : "Second Floor - Left 9 (Weapons Room Portal)",
		"2Left12.jpg" : "Second Floor - Left 9A (Weapons Display)",
		"2Left13.jpg" : "Second Floor - Left 10",
		"2Left14.jpg" : "Second Floor - Left 11",
		"2Left17.jpg" : "Second Floor - Left 12",
		"2Left19.jpg" : "Second Floor - Stairs Egress (Black Cat)",
		"LeftStairs1.jpg" : "Stairs to First Floor",
		"Img2023111613014500074.jpg" : "Museum Entrance from Left Stairs",
		"CatFinish" : "Credits Scene",
		"Img2024032114013000113PureShot.jpg" : "Museum Gate",
		"Tut1.jpg" : "Tutorial 1",
		"Tut2.jpg" : "Tutorial 2",
		"Tut3.jpg" : "Tutorial 3"
		}
		
		if location_name.has(str(data["current_location"])):
			slot.current_location_label.set_text("Current Location: " + location_name[(str(data["current_location"]))])
		else:
			slot.current_location_label.set_text("Current Location: " + data["current_location"])
		
		slot.quests_finished_label.set_text("Quests Finished: " + str(data["quests_completed"])) 
		
		slot.show_savedata()
		slot.has_savedata = true
		load_file.close()
	else:
		print("Save file does not exist")
		slot.no_save_data()
		slot.has_savedata = false
	
