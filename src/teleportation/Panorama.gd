@tool
class_name Panorama
extends Node3D

const AREAS_DIR = "res://src/areas/"

const IDLE_COLOR := Color("white")
const ACTIVE_COLOR := Color("red")

var data: Dictionary

@onready var offset: Vector3 = self.position

@onready var camera: XRCamera3D = XRHelpers.get_xr_camera(self.get_parent())

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var teleporters_container: Node3D = $Teleporters
@export var teleporters_data: Array

@export var image_filename: String

@export var base_rotation: float = 0.0

func _ready():
	mesh_instance.mesh = preload ("res://src/teleportation/PanoramaSphereMeshBase.tres")
	
	if teleporters_container.get_child_count() != teleporters_data.size():
		print("Setting teleporters...")
		_set_teleporters()
	
	# Add 360 image. Flip image horizontally to compensate for SphereMesh's Flip Faces property.
	var image = Image.load_from_file(image_filename)
	image.flip_x()
	var texture = ImageTexture.create_from_image(image)
	((mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture
	
	Events.connect("teleporter_hovered", _on_teleporter_hovered)
	Events.connect("no_teleporter_hovered", _on_no_teleporter_hovered)
	Events.connect("non_vr_teleporter_hovered", _on_teleporter_hovered)
	Events.connect("non_vr_no_teleporter_hovered", _on_no_teleporter_hovered)

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
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

func _set_teleporters():
	for teleporter in teleporters_container.get_children():
		teleporters_container.remove_child(teleporter)
		teleporter.queue_free()
	
	for teleporter_data in teleporters_data:
		print("Adding teleporter with data ", teleporter_data)
		
		var teleporter = preload ("res://src/teleportation/Teleporter.tscn").instantiate()
		teleporter.name = teleporter_data.to
		teleporter.position = teleporter_data.position
		teleporter.to = teleporter_data.to
		
		teleporters_container.add_child(teleporter)
		teleporter.owner = self

# TELEPORTER SIGNALS
func _on_teleporter_hovered(teleporter: Teleporter):
	if teleporter and teleporter.enabled:
		teleporter.set_color(ACTIVE_COLOR)

func _on_no_teleporter_hovered():
	for teleporter in teleporters_container.get_children():
		teleporter.set_color(IDLE_COLOR)
