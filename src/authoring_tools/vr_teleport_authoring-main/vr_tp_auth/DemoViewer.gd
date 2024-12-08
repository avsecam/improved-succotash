extends Node3D

const teleporter_scene: PackedScene = preload("res://src/teleportation/Teleporter.tscn")

@onready var mesh: MeshInstance3D = $Bubble
@onready var camera: Camera3D = $Bubble/Camera3D

@onready var teleporters: Node3D = $Bubble/Teleporters

@onready var authoring: TeleportAuthor = %TeleportAuthor

@export var rotation_speed: float = 0.01
@export var indicator_move_speed: float = 0.25

var node: TeleportNode # Get/save all data from/to here

func _ready():
	Events.demo_requested.connect(_on_demo_requested)
	Events.demo_exit_requested.connect(_on_demo_exit_requested)
	Events.teleport_requested.connect(_on_teleport_requested)

func _process(_delta):
	self.visible = false
	# Invert camera to compensate for inverted 360 image
	camera.scale = Vector3(-1, 1, 1)
	
	if not get_viewport().is_input_handled():
		if Input.is_action_pressed("ui_left"):
			camera.rotation.y -= rotation_speed
		if Input.is_action_pressed("ui_right"):
			camera.rotation.y += rotation_speed
	
	# Reset colors of Teleporters
	for teleporter in teleporters.get_children():
		teleporter.set_hovered(false)
	
	handle_aim()

	# Keep camera rotation level
	camera.rotation.x = 0
	camera.rotation.z = 0

func handle_aim():
	var viewport := get_viewport()
	var mouse_pos := viewport.get_mouse_position()

	var origin := camera.project_ray_origin(mouse_pos)
	var direction := camera.project_ray_normal(mouse_pos)

	var ray_length := camera.far
	var end := origin + direction * ray_length

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = 0b00000000_00000000_00000010_00000000
	var result := space_state.intersect_ray(query)

	var collider = result.get("collider")
	if collider:
		(collider as TeleporterAuth).set_hovered(true)
		
		if Input.is_action_just_pressed("mouse_left"):
			Events.teleport_requested.emit(collider.teleport_location)

func _update(new_node: TeleportNode):
	self.node = new_node
	self.mesh.mesh.material.albedo_texture = new_node.sprite.texture
	self.camera.current = true
	self.camera.rotation.y = new_node.base_rotation
	
	# Remove teleporters
	for teleporter in teleporters.get_children():
		teleporters.remove_child(teleporter)
	
	# Load teleporters from TeleportNode
	for i in new_node.teleporters.size():
		teleporters.add_child(new_node.teleporters[i])
	
	self.visible = true

func _on_demo_requested(start_node: TeleportNode):
	_update(start_node)

func _on_demo_exit_requested():
	self.node = null
	
	# Clear teleporters
	for i in teleporters.get_child_count():
		var teleporter = teleporters.get_child(0)
		teleporters.remove_child(teleporter)
	
	self.visible = false

func _on_teleport_requested(teleport_node: TeleportNode):
	_update(teleport_node)
