class_name Panorama
extends Node3D


const AREAS_DIR = "res://src/areas/"

@export var data_filename: String # json filename
var data: Dictionary

@onready var offset: Vector3 = self.position

@onready var camera: XRCamera3D = XRHelpers.get_xr_camera(self.get_parent())

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var teleporters: Node3D = $Teleporters


func _ready():
	mesh_instance.mesh = preload("res://src/teleportation/PanoramaSphereMeshBase.tres")
	
	if data_filename.is_empty():
		push_error("Panorama:data_filename must be set initially.")
	
	Events.player_teleport_requested_trigger.connect(_on_player_teleport_requested)
	
	update_panorama(data_filename)


func _physics_process(delta):
	if camera:
		self.global_position = camera.global_position
	else:
		self.global_position = Vector3(0, 0, 0)


func update_panorama(new_data_filename: String):
	var json_as_text = FileAccess.get_file_as_string(AREAS_DIR + new_data_filename)
	data = JSON.parse_string(json_as_text)
	
	# Update 360 image
	var image = Image.load_from_file(AREAS_DIR + (data.panorama_texture_filename))
	var texture = ImageTexture.create_from_image(image)
	((mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture
	
	# Face default direction
	
	# Remove all teleporters
	for i in teleporters.get_child_count():
		var teleporter = teleporters.get_child(0)
		teleporters.remove_child(teleporter)
		teleporter.queue_free()

	# Add teleporters
	for i in data.teleporter_positions.size():
		var teleporter_position: Vector3 = Vector3(
			data.teleporter_positions[i].position_x,
			data.teleporter_positions[i].position_y,
			data.teleporter_positions[i].position_z
		)
		var teleporter_location_filename: String = data.teleporter_positions[i].teleport_location_filename
		
		var new_teleporter: Teleporter = preload("res://src/teleportation/Teleporter.tscn").instantiate()
		new_teleporter.position = teleporter_position
		new_teleporter.to = teleporter_location_filename
		
		teleporters.add_child(new_teleporter)


func _on_player_teleport_requested(new_data_filename: String):
	update_panorama(new_data_filename)
