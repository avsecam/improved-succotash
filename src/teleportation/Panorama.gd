@tool
class_name Panorama
extends Level

@export var image_filename: String

func _ready():
	super()
	mesh_instance.mesh = preload("res://src/teleportation/PanoramaSphereMeshBase.tres")
	
	# Changed into this code to allow for exported projects to access the filesystem.
	print("Loaded "+image_filename)
	var image : Image = load(image_filename).get_image()
	image.flip_x()
	var texture_panorama = ImageTexture.create_from_image(image)
	((mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture_panorama
	
func _physics_process(delta):
	super(delta)
	
	# Don't let sphere move around relative to player camera
	if camera:
		self.global_position = camera.global_position
	else:
		self.global_position = Vector3(0, 0, 0)

func update_panorama(new_data_filename: String):
	var json_as_text = FileAccess.get_file_as_string(AREAS_DIR + new_data_filename)
	data = JSON.parse_string(json_as_text)
	
	# Remove all teleporters
	for i in teleporters_container.get_child_count():
		var teleporter = teleporters_container.get_child(0)
		teleporters_container.remove_child(teleporter)
		teleporter.queue_free()

	# Add teleporters
	for i in data.teleporter_positions.size():
		var teleporter_position: Vector3 = Vector3(
			data.teleporter_positions[i].position_x,
			data.teleporter_positions[i].position_y,
			data.teleporter_positions[i].position_z
		)
		var teleporter_location_filename: String = data.teleporter_positions[i].teleport_location_filename
		
		var new_teleporter: Teleporter = preload ("res://src/teleportation/Teleporter.tscn").instantiate()
		new_teleporter.position = teleporter_position
		new_teleporter.to = teleporter_location_filename
		
		teleporters_container.add_child(new_teleporter)
