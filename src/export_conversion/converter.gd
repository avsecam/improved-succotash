@tool
extends EditorScript

const AREAS_DIR = "res://src/areas/"

func _run():
	var files_dir = DirAccess.open(AREAS_DIR)
	var files = files_dir.get_files()
	
	for file in files:
		if file.ends_with(".json") and file.contains("obj"):
			var level = convertToScene(file)

			var scene = PackedScene.new()
			scene.pack(level)
			ResourceSaver.save(scene, AREAS_DIR + file.replace(".json", ".tscn"))

			print("Converted " + file)

func convertToScene(filename: String) -> Level:
	var json_data = FileAccess.get_file_as_string(AREAS_DIR + filename)
	
	var data = JSON.parse_string(json_data)
	print(data)

	var level: Level
	
	if data.mesh_filename:
		level = preload("res://src/teleportation/ThreeDScene.tscn").instantiate()
		level.obj_filename = (AREAS_DIR + (data.mesh_filename))
	else:
		level = preload("res://src/teleportation/Panorama.tscn").instantiate()
		# Set 360 image filename
		level.image_filename = (AREAS_DIR + (data.panorama_texture_filename))

	level.name = data.area_name
	
	# Set base rotation
	level.base_rotation = data.base_rotation

	# Set teleporters
	for teleporter_data in data.teleporter_positions:
		var new_data = {}
		new_data.position = Vector3(
			teleporter_data.position_x,
			teleporter_data.position_y,
			teleporter_data.position_z
		)

		new_data.to = (teleporter_data.teleport_location_filename as String).get_slice(".json", 0)

		level.teleporters_data.append(new_data)
	
	for teleporter_data in data.teleport_spots:
		var new_data = {}
		new_data.position = Vector3(
			teleporter_data.position_x,
			teleporter_data.position_y,
			teleporter_data.position_z
		)

		level.teleporters_data.append(new_data)
	
	print(level.teleporters_data)
	
	return level
