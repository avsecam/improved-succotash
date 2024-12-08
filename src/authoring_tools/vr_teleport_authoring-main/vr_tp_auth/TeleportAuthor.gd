class_name TeleportAuthor
extends Node2D

@onready var nodes: Node2D = $TeleportNodes

var in_edit_connections_mode := false
var in_edit_node_mode := false

func _ready():
	Events.teleport_node_selected.connect(_on_teleport_node_selected)
	Events.teleport_node_drag_started.connect(_on_teleport_node_drag_started)
	Events.teleport_node_add_requested.connect(_on_teleport_node_add_requested)
	Events.teleport_node_delete_requested.connect(_on_teleport_node_delete_requested)
	Events.teleport_node_edit_requested.connect(_on_teleport_node_edit_requested)
	Events.teleport_node_edit_confirm_requested.connect(_on_teleport_node_edit_confirm_requested)
	Events.teleport_node_connection_add_requested.connect(_on_teleport_node_connection_add_requested)
	
	Events.teleport_node_enter_requested.connect(_on_teleport_node_enter_requested)
	Events.teleport_node_exit_requested.connect(_on_teleport_node_exit_requested)
	
	Events.demo_requested.connect(_on_demo_requested)
	Events.demo_exit_requested.connect(_on_demo_exit_requested)
	
	Events.export_requested.connect(_on_export_requested)
	Events.save_requested.connect(_on_save_requested)
	Events.load_requested.connect(_on_load_requested)

# Get the current selected TeleportNode
func child_selected():
	for child in nodes.get_children():
		if (child as TeleportNode).selected:
			return child
	return null

func _on_teleport_node_selected(node: TeleportNode):
	if in_edit_connections_mode:
		# Add a connection if editing connections
		if not self.child_selected().get_path() == node.get_path():
			_on_teleport_node_connection_add_requested(node)
	else:
		# Select or deselect node
		if not node.selected:
			for child in nodes.get_children():
				(child as TeleportNode).selected = false
			
			node.selected = true
		else:
			node.selected = false

func _on_teleport_node_drag_started(node: TeleportNode):
	# Only allow one node to be dragged at any time
	for child in nodes.get_children():
		(child as TeleportNode).can_drag = false
	
	node.can_drag = true

func _on_teleport_node_add_requested(node: TeleportNode, internal_name: String):
	# Add node at center of screen
	var node_position: Vector2 = % "Camera2D".position
	node.position = node_position
	node.name = internal_name
	nodes.add_child(node)

func _on_teleport_node_delete_requested(node: TeleportNode):
	# Delete connections from other nodes
	for child in nodes.get_children():
		# Find node that is being deleted
		for i in (child as TeleportNode).teleport_connections.size():
			var area: NodePath = (child as TeleportNode).teleport_connections[i]
			if area.get_name(area.get_name_count() - 1) == node.name:
				(child as TeleportNode).teleport_connections.remove_at(i)
				break
	
	node.queue_free()

func _on_teleport_node_edit_requested(_node: TeleportNode):
	in_edit_connections_mode = true

func _on_teleport_node_edit_confirm_requested(_node: TeleportNode):
	in_edit_connections_mode = false

func _on_teleport_node_connection_add_requested(to: TeleportNode):
	var from = self.child_selected()
	var teleport_connections = from.teleport_connections
	
	for i in range(teleport_connections.size()):
		var node: NodePath = teleport_connections[i]
		if node.get_name(node.get_name_count() - 1) == to.name:
			teleport_connections.remove_at(i)
			return
	
	from.add_teleport_connection(to)

func _on_teleport_node_enter_requested(_a):
	self.visible = false	

func _on_teleport_node_exit_requested(_a):
	self.visible = true

func _on_demo_requested(_a):
	self.visible = false

func _on_demo_exit_requested():
	self.visible = true

# TODO: Dont allow same named nodes
# Export the current project to JSONs to be used in a separate project
func _on_export_requested():
	var folder_name: String = "exported_" + str(floor(Time.get_unix_time_from_system()))
	var dir: DirAccess = DirAccess.open("user://")
	if dir:
		dir.make_dir(folder_name)
	
	var full_dir_name: String = "user://" + folder_name + "/"
	
	for i in nodes.get_child_count():
		var node: TeleportNode = nodes.get_child(i)
		var filename: String = full_dir_name + node.area_name.to_pascal_case() + ".json"
		
		var image_filename: String
		var obj_filename: String

		# Export 3D Scene or 360 Image Scene
		if node.mesh:
			obj_filename = full_dir_name + node.mesh_filename
			DirAccess.copy_absolute(node.mesh_filename, full_dir_name + node.area_name.to_pascal_case().get_file())
		else:
			image_filename = full_dir_name + node.area_name.to_pascal_case() + ".jpg"
			var image = Image.load_from_file(node.sprite_texture_filename)
			image.save_jpg(image_filename)
		
		var exported_tp_node = {
			"panorama_texture_filename": node.area_name.to_pascal_case() + ".jpg" if not node.mesh else "",
			"mesh_filename": node.area_name.to_pascal_case() + ".obj" if node.mesh else "",
			"area_name": node.area_name,
			"base_rotation": node.base_rotation if node.base_rotation else float(0),
			"teleporter_positions": [], # {position, teleport_location_filepath}
			"teleport_spots": []
		}
		
		for j in node.teleporters.size():
			var teleporter: TeleporterOutsideConnection = node.teleporters[j]
			(exported_tp_node.teleporter_positions as Array).append({
				"position_x": -teleporter.position.x,
				"position_y": teleporter.position.y,
				"position_z": teleporter.position.z,
				"rotation_x": teleporter.rotation.x,
				"rotation_y": teleporter.rotation.y,
				"rotation_z": teleporter.rotation.z,
				"teleport_location_filename": teleporter.teleport_location.area_name.to_pascal_case() + ".json"
			})
		
		if node.mesh:
			for j in node.teleporters.size():
				var teleporter: TeleporterAuth = node.teleporters[j]
				(exported_tp_node.teleport_spots as Array).append({
					"position_x": -teleporter.position.x,
					"position_y": teleporter.position.y,
					"position_z": teleporter.position.z,
					"rotation_x": teleporter.rotation.x,
					"rotation_y": teleporter.rotation.y,
					"rotation_z": teleporter.rotation.z
				})
		
		var file = FileAccess.open(filename, FileAccess.WRITE)
		file.store_string(JSON.stringify(exported_tp_node))
	
	# Open folder containing scenes
	OS.shell_show_in_file_manager(ProjectSettings.globalize_path(full_dir_name))

# Save all nodes and flags for future use within this project
func _on_save_requested():
	var folder_name: String = "saved_" + str(floor(Time.get_unix_time_from_system()))
	var dir: DirAccess = DirAccess.open("user://")
	if dir:
		dir.make_dir(folder_name)
	
	var full_dir_name: String = "user://" + folder_name + "/"
	
	# Save children of TeleportNodes
	for i in %TeleportNodes.get_child_count():
		var teleport_node: TeleportNode = %TeleportNodes.get_child(i)
		
		var saved_teleport_node: SavedTeleportNode = SavedTeleportNode.new()
		saved_teleport_node.area_name = teleport_node.area_name
		
		# prioritize 3D scenes
		if teleport_node.mesh:
			saved_teleport_node.obj_filename = teleport_node.mesh_filename
		else:
			saved_teleport_node.sprite_texture_filename = teleport_node.sprite_texture_filename
		
		saved_teleport_node.node_path = teleport_node.get_path()
		saved_teleport_node.overview_position = teleport_node.position
		saved_teleport_node.base_rotation = teleport_node.base_rotation
		
		# Save connections
		for j in teleport_node.teleport_connections.size():
			var connection: NodePath = teleport_node.teleport_connections[j]
			
			saved_teleport_node.teleport_connections_node_paths.append(connection)
		
		# Save teleporters
		for j in teleport_node.teleporters.size():
			var teleporter: TeleporterOutsideConnection = teleport_node.teleporters[j]

			if is_instance_valid(teleporter.teleport_location):
				saved_teleport_node.teleporters.append({
					"position": teleporter.position,
					"rotation": teleporter.rotation,
					"to": teleporter.teleport_location.get_path() if teleporter.teleport_location else ""
				})
		
		# Save teleport_spots
		for j in teleport_node.teleport_spots.size():
			var teleporter: TeleporterAuth = teleport_node.teleport_spots[j]
			saved_teleport_node.teleport_spots.append({
				"position": teleporter.position,
				"rotation": teleporter.rotation
			})
		
		ResourceSaver.save(saved_teleport_node, full_dir_name + saved_teleport_node.area_name + ".tres")
	
	# Save event flags
	var event_flags_save = FileAccess.open(full_dir_name + "flags.json", FileAccess.WRITE)
	event_flags_save.store_string(JSON.stringify(EventFlags.data))
	
	OS.shell_show_in_file_manager(ProjectSettings.globalize_path(full_dir_name))
	Events.save_finished.emit()

# Load file saved from _on_save_requested()
func _on_load_requested(file_path: String):
	# Clear TeleportNodes
	for i in %TeleportNodes.get_child_count():
		var teleport_node: TeleportNode = %TeleportNodes.get_child(0)
		%TeleportNodes.remove_child(teleport_node)
		teleport_node.queue_free()
	
	# Clear and load flags
	EventFlags.clear()
	
	var flags_file = FileAccess.open(file_path + "/flags.json", FileAccess.READ)
	if flags_file == null:
		EventFlags.data = {}
	else:
		var flags_json = JSON.parse_string(flags_file.get_as_text())
		for key in (flags_json as Dictionary).keys():
			Events.trigger_add_requested.emit(key)
	
	# Load TeleportNodes
	var dir_access: DirAccess = DirAccess.open(file_path)
	var files: PackedStringArray = dir_access.get_files()
	var tres_files: PackedStringArray
	
	for i in files.size():
		var file: String = files[i]
		if file.get_extension() == "tres":
			tres_files.append(file)
	
	for i in tres_files.size():
		var file: String = tres_files[i]
		
		var absolute_file_path = file_path + "/" + file
		ResourceLoader.load_threaded_request(absolute_file_path)
		var saved_teleport_node: SavedTeleportNode = ResourceLoader.load_threaded_get(absolute_file_path)
		
		var teleport_node: TeleportNode = preload ("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/TeleportNode.tscn").instantiate()
		teleport_node.area_name = saved_teleport_node.area_name
		
		# Prioritize 3D scenes
		if saved_teleport_node.obj_filename:
			teleport_node.mesh = load(saved_teleport_node.obj_filename)
			teleport_node.mesh_filename = saved_teleport_node.obj_filename
		else:
			teleport_node.sprite_texture_filename = saved_teleport_node.sprite_texture_filename
		teleport_node.position = saved_teleport_node.overview_position
		teleport_node.base_rotation = saved_teleport_node.base_rotation
		
		var saved_teleport_node_node_path: NodePath = saved_teleport_node.node_path
		teleport_node.name = saved_teleport_node_node_path.get_name(saved_teleport_node_node_path.get_name_count() - 1)
		
		%TeleportNodes.add_child(teleport_node)
	
	# Add connections and teleporters
	for i in tres_files.size():
		var file: String = tres_files[i]
		if file.get_extension() != "tres":
			continue
		
		var absolute_file_path = file_path + "/" + file
		ResourceLoader.load_threaded_request(absolute_file_path)
		var saved_teleport_node: SavedTeleportNode = ResourceLoader.load_threaded_get(absolute_file_path)
		
		var teleport_node: TeleportNode = %TeleportNodes.get_child(i)
		
		# Load connections
		for j in saved_teleport_node.teleport_connections_node_paths.size():
			var connection: NodePath = saved_teleport_node.teleport_connections_node_paths[j]
			
			# Needed because names like @StaticBody2D@96 get turned into _StaticBody2D_96
			var connection_formatted: NodePath = str(connection).replace("@", "_")
			
			teleport_node.teleport_connections.append(connection_formatted)
		
		# Load teleporters
		for j in saved_teleport_node.teleporters.size():
			var teleporter: Dictionary = saved_teleport_node.teleporters[j]
			
			var new_teleporter: TeleporterOutsideConnection = preload ("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/TeleporterOutsideConnection.tscn").instantiate()
			new_teleporter.position = teleporter["position"]
			new_teleporter.rotation = teleporter["rotation"]
			new_teleporter.teleport_location = get_node(teleporter["to"])
			if (saved_teleport_node.area_name as String).contains("obj"):
				print(teleporter)
			teleport_node.teleporters.append(new_teleporter)
		
		# Load teleport_spots if 3D scene
		if saved_teleport_node.obj_filename:
			for j in saved_teleport_node.teleport_spots.size():
				var teleporter: Dictionary = saved_teleport_node.teleport_spots[j]
				
				var new_teleporter: TeleporterAuth = preload ("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/Teleporter.tscn").instantiate()
				new_teleporter.position = teleporter["position"]
				new_teleporter.rotation = teleporter["rotation"]
				
				teleport_node.teleport_spots.append(new_teleporter)
