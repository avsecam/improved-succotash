extends Node3D

const teleporter_scene: PackedScene = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/Teleporter.tscn")
const teleporter_oc_scene: PackedScene = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/TeleporterOutsideConnection.tscn")

const default_bubble_position: Vector3 = Vector3(0, 1.365, 0)

@onready var mesh: MeshInstance3D = $Bubble
@onready var camera: Camera3D = $Bubble/Camera3D
@onready var three_d_scene: MeshInstance3D = $"3DScene"

@onready var floor_checker: RayCast3D = $Bubble/Camera3D/RayCast3D

@onready var indicator_anchor: Node3D = $Bubble/Camera3D/TeleporterIndicatorAnchor
@onready var indicator: Teleporter = $Bubble/Camera3D/TeleporterIndicatorAnchor/TeleporterIndicator

@onready var teleporters: Node3D = $Bubble/Teleporters
@onready var teleporters_three_d_scene: Node3D = $"3DScene/Teleporters"

@onready var min_indicator_distance: float = 1 + 0.5
@onready var max_indicator_distance: float = (mesh.mesh as SphereMesh).radius - 0.5

@onready var authoring: TeleportAuthor = %TeleportAuthor

@export var rotation_speed: float = 0.01
@export var move_speed: float = 0.1
@export var indicator_move_speed: float = 0.25
@export var mouse_sensitivity: float = 0.005

var node: TeleportNode # Get/save all data from/to here

func _ready():
	indicator.position.z = indicator.position.z - min_indicator_distance
	
	Events.teleport_node_enter_requested.connect(_on_teleport_node_enter_requested)
	Events.teleport_node_exit_requested.connect(_on_teleport_node_exit_requested)
	
	Events.teleporter_add_finished.connect(_on_teleporter_add_finished)
	
	Events.connection_entry_select_requested.connect(_on_connection_entry_select_requested)
	Events.connection_entry_delete_requested.connect(_on_connection_entry_delete_requested)

func _process(_delta):
	if not authoring.in_edit_node_mode:
		return
		
	if self.is_three_d_scene():
		self.mesh.visible = false
		self.three_d_scene.visible = true
		
		self.mesh.position.y = 2
		
		var input_dir = Vector3()
		if Input.is_action_pressed("ui_left"):
			input_dir -= mesh.global_basis.x
		if Input.is_action_pressed("ui_right"):
			input_dir += mesh.global_basis.x
		if Input.is_action_pressed("ui_up"):
			input_dir += mesh.global_basis.z
		if Input.is_action_pressed("ui_down"):
			input_dir -= mesh.global_basis.z
		input_dir = input_dir.normalized()
		self.mesh.position += input_dir * move_speed
		
		if floor_checker.is_colliding():
			if Input.is_action_just_pressed("place_teleporter"):
				add_teleporter()
	else:
		self.mesh.visible = true
		self.three_d_scene.visible = false
		
		# Invert camera to compensate for inverted 360 image
		camera.scale = Vector3(-1, 1, 1)
		
		if Input.is_action_pressed("ui_left"):
			camera.rotation.y -= rotation_speed
		if Input.is_action_pressed("ui_right"):
			camera.rotation.y += rotation_speed
		if Input.is_action_pressed("ui_up"):
			indicator_anchor.rotate_x(rotation_speed)
		if Input.is_action_pressed("ui_down"):
			indicator_anchor.rotate_x(-rotation_speed)
		
		if Input.is_action_just_pressed("place_base_rotation"):
			replace_base_rotation()
		
		if not can_add_teleporter():
			indicator.visible = false
		else:
			indicator.visible = true
			if Input.is_action_just_pressed("mouse_scroll_down"):
				if abs(indicator.position.distance_to(camera.position)) > min_indicator_distance:
					indicator.position.z += indicator_move_speed
			if Input.is_action_just_pressed("mouse_scroll_up"):
				if abs(indicator.position.distance_to(camera.position)) < max_indicator_distance:
					indicator.position.z -= indicator_move_speed
			
			if Input.is_action_just_pressed("place_teleporter"):
				add_teleporter()

		indicator.global_rotation.x = 0
		
		# Keep camera rotation level
		camera.rotation.x = 0
		camera.rotation.z = 0

func _input(event):
	if self.is_three_d_scene():
		if Input.is_action_pressed("free_mouse"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			if event is InputEventMouseMotion:
				self.mesh.rotate_y(event.relative.x * mouse_sensitivity)
				self.camera.rotate_x(event.relative.y * mouse_sensitivity)
				#self.camera.rotation.x = clamp(self.camera.rotation.x, -1.2, 1.2)
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func is_three_d_scene():
	if not node:
		return false
	return true if node.mesh != null else false

func can_add_teleporter():
	return teleporters.get_child_count() < node.teleport_connections.size()

func add_teleporter():
	if is_three_d_scene():
		print(floor_checker.get_collision_point())
		Events.teleporter_add_requested.emit(node, floor_checker.get_collision_point(), Vector3())
	else:
		Events.teleporter_add_requested.emit(node, indicator.global_position, indicator.global_rotation)

func replace_base_rotation():
	var view_rotation = camera.rotation.y
	node.base_rotation = view_rotation
	
	print(view_rotation, " set as base rotation.")

# Set stuff before entering node
func _on_teleport_node_enter_requested(node_to_enter: TeleportNode):
	self.node = node_to_enter
	
	if node_to_enter.sprite_texture_filename:
		self.mesh.mesh.material.albedo_texture = node_to_enter.sprite.texture
		
		# Load teleporters from TeleportNode
		for i in node_to_enter.teleporters.size():
			teleporters.add_child(node_to_enter.teleporters[i])
	else:
		self.three_d_scene.mesh = Mesh.new()
		self.three_d_scene.mesh = node_to_enter.mesh
		self.three_d_scene.create_trimesh_collision()
		
		# Load teleporters and teleport_spots from TeleportNode
		for i in node_to_enter.teleporters.size():
			teleporters_three_d_scene.add_child(node_to_enter.teleporters[i])
		for i in node_to_enter.teleport_spots.size():
			teleporters_three_d_scene.add_child(node_to_enter.teleport_spots[i])
	
	self.camera.current = true
	self.camera.rotation.y = node_to_enter.base_rotation
	
	self.visible = true
	
	#camera.scale = Vector3(1, -1, 1)
	
	authoring.in_edit_node_mode = true

func _on_teleport_node_exit_requested(node_to_exit: TeleportNode):
	self.node = node_to_exit
	
	# Clear teleporters
	for i in teleporters.get_child_count():
		var teleporter = teleporters.get_child(0)
		teleporters.remove_child(teleporter)
	
	self.visible = false
	authoring.in_edit_node_mode = false

func _on_teleporter_add_finished(node: TeleportNode, teleporter: TeleporterAuth, pos: Vector3, rot: Vector3):
	if is_three_d_scene():
		teleporters_three_d_scene.add_child(teleporter)
	else:
		teleporters.add_child(teleporter)
	teleporter.global_position = pos
	teleporter.global_rotation = rot

func _on_connection_entry_select_requested(entry: ConnectionEntry):
	# Look at selected entry's assigned teleporter
	if entry.teleporter:
		camera.look_at(entry.teleporter.position)

func _on_connection_entry_delete_requested(entry: ConnectionEntry):
	if entry.teleporter is TeleporterOutsideConnection:
		var teleporter_idx: int = node.teleporters.find(entry.teleporter)
	
		teleporters.remove_child(entry.teleporter)
		entry.teleporter.queue_free()
	
		entry.teleporter = null
		node.teleporters.remove_at(teleporter_idx)
	else:
		var teleporter_idx: int = node.teleport_spots.find(entry.teleporter)
	
		teleporters.remove_child(entry.teleporter)
		entry.teleporter.queue_free()
		
		node.teleport_spots.remove_at(teleporter_idx)
		entry.queue_free()
