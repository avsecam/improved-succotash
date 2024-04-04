extends Object

const AREAS_DIR = "res://src/areas/"

func convertToScene(json_data: String):
	var data = JSON.parse_string(json_data)

	var panorama = preload("res://src/teleportation/Panorama.tscn").instantiate()

	panorama.name = data.area_name
	
	# Set 360 image
	var image = Image.load_from_file(AREAS_DIR + (data.panorama_texture_filename))
	var texture = ImageTexture.create_from_image(image)
	((panorama.mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture

	# Set teleporters
	for teleporter_position in data.teleporter_positions:
		var teleporter = preload("res://src/teleportation/Teleporter.tscn").instantiate()
		
		teleporter.position = Vector3(
			teleporter_position.position.x,
			teleporter_position.position.y,
			teleporter_position.position.z
		)

		teleporter.to = teleporter_position.teleport_location_filename

		panorama.teleporters.add_child(teleporter)
	