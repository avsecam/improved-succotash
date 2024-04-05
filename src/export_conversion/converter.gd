@tool
extends EditorScript

const AREAS_DIR = "res://src/areas/"

func _run():
	var files_dir = DirAccess.open(AREAS_DIR)
	var files = files_dir.get_files()
	
	for file in files:
		if file.ends_with(".json"):
			var panorama = convertToScene(file)

			var scene = PackedScene.new()
			scene.pack(panorama)
			ResourceSaver.save(scene, AREAS_DIR + file.replace(".json", ".tscn"))

			print("Converted " + file)

func convertToScene(filename: String) -> Panorama:
	var json_data = FileAccess.get_file_as_string(AREAS_DIR + filename)
	
	var data = JSON.parse_string(json_data)

	var panorama = preload ("res://src/teleportation/Panorama.tscn").instantiate()

	panorama.name = data.area_name
	
	# Set 360 image filename
	panorama.image_filename = (AREAS_DIR + (data.panorama_texture_filename))

	# Set teleporters
	for teleporter_data in data.teleporter_positions:
		var new_data = {}
		new_data.position = Vector3(
			teleporter_data.position_x,
			teleporter_data.position_y,
			teleporter_data.position_z
		)

		new_data.to = (teleporter_data.teleport_location_filename as String).get_slice(".json", 0)

		panorama.teleporters_data.append(new_data)
	
	return panorama
