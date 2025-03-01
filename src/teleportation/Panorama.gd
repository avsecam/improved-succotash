@tool
class_name Panorama
extends Node3D

const AREAS_DIR = "res://src/areas/"

const IDLE_COLOR := Color("white")
const ACTIVE_COLOR := Color("red")
const SPECIAL_IDLE_COLOR := Color(Color.DARK_SEA_GREEN)
const SPECIAL_ACTIVE_COLOR := Color(Color.GREEN_YELLOW)
const DISABLED_COLOR := Color(Color.DARK_SLATE_GRAY)

var data: Dictionary

@onready var offset: Vector3 = self.position

@onready var camera: XRCamera3D = XRHelpers.get_xr_camera(self.get_parent())
# Connect hands to teleporters
@onready var hand_left = get_tree().get_root().get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand/FunctionPickup")
@onready var hand_right = get_tree().get_root().get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/FunctionPickup")

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var teleporters_container: Node3D = $Teleporters
@export var teleporters_data: Array

@export var image_filename: String

@export var base_rotation: float = 0.0

@onready var events_node = $Events


func _ready():
	mesh_instance.mesh = preload ("res://src/teleportation/PanoramaSphereMeshBase.tres")
	
	for teleporter in teleporters_container.get_children():
		teleporters_container.remove_child(teleporter)
		teleporter.queue_free()
	
	_set_teleporters()
	
	for teleporter in teleporters_container.get_children():
		if teleporter.special:
			teleporter.set_color(SPECIAL_IDLE_COLOR)
	
	# Add 360 image. Flip image horizontally to compensate for SphereMesh's Flip Faces property.
	#var image = Image.load_from_file(image_filename)
	#image.flip_x()
	#var texture = ImageTexture.create_from_image(image)
	#((mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture
	
	# Changed into this code to allow for exported projects to access the filesystem.
	print("Loaded "+image_filename)
	var image : Image = load(image_filename).get_image()
	image.flip_x()
	var texture_panorama = ImageTexture.create_from_image(image)
	((mesh_instance.mesh as SphereMesh).material as StandardMaterial3D).albedo_texture = texture_panorama
	
	Events.connect("teleporter_hovered", _on_teleporter_hovered)
	Events.connect("no_teleporter_hovered", _on_no_teleporter_hovered)
	Events.connect("non_vr_teleporter_hovered", _on_teleporter_hovered)
	Events.connect("non_vr_no_teleporter_hovered", _on_no_teleporter_hovered)
	
	# Connect hand signals to panorama
	hand_left.connect("has_picked_up", _on_picked_up)
	hand_right.connect("has_picked_up",_on_picked_up)
	hand_left.connect("has_dropped",_on_release)
	hand_right.connect("has_dropped",_on_release)
	
	if camera:
		self.global_position = camera.global_position


func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	
	# Don't let sphere move around relative to player camera
	
	#else:
		#self.global_position = Vector3(0, 0, 0)

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
	for teleporter_data in teleporters_data:
		print("Adding teleporter with data ", teleporter_data)
		
		var teleporter = preload ("res://src/teleportation/Teleporter.tscn").instantiate()
		teleporter.name = teleporter_data.to
		teleporter.position = teleporter_data.position
		if teleporter_data.has("rotation"):
			teleporter.rotation.y = teleporter_data.rotation.y
		teleporter.to = teleporter_data.to
		
		if teleporter_data.has("special"):
			teleporter.special = teleporter_data.special
		
		teleporters_container.add_child(teleporter)
		teleporter.owner = self

# TELEPORTER SIGNALS
func _on_teleporter_hovered(teleporter: Teleporter):
	print (teleporter)
	if teleporter and teleporter.enabled:
		if teleporter.special:
			teleporter.set_color(SPECIAL_ACTIVE_COLOR)
		else:
			teleporter.set_color(ACTIVE_COLOR)
		AudioHandler.play_sfx("UI_Tele_Hover", null)

func _on_no_teleporter_hovered():
	for teleporter in teleporters_container.get_children():
		if teleporter.special:
			teleporter.set_color(SPECIAL_IDLE_COLOR)
		else:
			teleporter.set_color(IDLE_COLOR)

func _on_picked_up(what):
	print("===== CURRENTLY PICKED SOMETHING UP: "+what.name)
	for teleporter in teleporters_container.get_children():
		if teleporter.special:
			teleporter.play_special_closing_portal()
		else:
			teleporter.set_color(DISABLED_COLOR)
			teleporter.enabled = false
		
func _on_release():
	print("====== RELEASED GRABBED ITEM")
	for teleporter in teleporters_container.get_children():
		if Events.locked_teleporters.has(teleporter.name):
			if Events.locked_teleporters[teleporter.name] in Events.finished_events:
				if teleporter.special:
					teleporter.play_special_opening_portal()
				else:
					teleporter.set_color(IDLE_COLOR)
					teleporter.enabled = true
		else:
			if teleporter.special:
				teleporter.play_special_opening_portal()
			else:
				teleporter.set_color(IDLE_COLOR)
				teleporter.enabled = true
		
