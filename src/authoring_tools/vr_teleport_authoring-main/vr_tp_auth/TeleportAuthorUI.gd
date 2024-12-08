extends Control

const connection_entry: PackedScene = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/ConnectionEntry.tscn")
const teleporter_scene: PackedScene = preload("res://src/teleportation/Teleporter.tscn")
const teleporter_oc_scene: PackedScene = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/TeleporterOutsideConnection.tscn")

@onready var project_title: Label = $TopUI/CenterContainer/VBoxContainer/ProjectTitle
@onready var demo_button: Button = $TopUI/CenterContainer/VBoxContainer/Demo

# List of teleport connections on the left of the screen
@onready var entity_list: VBoxContainer = $LeftUI/VBoxContainer/EntityList

@onready var file_dialog: FileDialog = $FileDialog

@onready var teleport_author: TeleportAuthor = %TeleportAuthor

@onready var switch_button: Button = $Container/HBoxContainer/Switch

@onready var add_node_button: Button = $Container/HBoxContainer/VBoxContainer/AddNode
@onready var delete_node_button: Button = $Container/HBoxContainer/VBoxContainer/DeleteNode
@onready var edit_connections_button: Button = $Container/HBoxContainer/EditConnections
@onready var enter_node_button: Button = $Container/HBoxContainer/EnterNode

@onready var add_object_button: Button = $Container/HBoxContainer/VBoxContainer/AddObject
@onready var delete_object_button: Button = $Container/HBoxContainer/VBoxContainer/DeleteObject

@onready var export_button: Button = $Container/HBoxContainer/Export
@onready var save_button: Button = $Container/HBoxContainer/Save
@onready var load_button: Button = $Container/HBoxContainer/Load

func _ready():
	# Teleport Author buttons
	add_node_button.pressed.connect(_on_add_node_button_pressed)
	delete_node_button.pressed.connect(_on_delete_node_button_pressed)
	edit_connections_button.pressed.connect(_on_edit_connections_button_pressed)
	enter_node_button.pressed.connect(_on_enter_node_button_pressed)
	
	# Common buttons
	demo_button.pressed.connect(_on_demo_button_pressed)
	
	export_button.pressed.connect(_on_export_button_pressed)
	save_button.pressed.connect(_on_save_button_pressed)
	load_button.pressed.connect(_on_load_button_pressed)
	
	file_dialog.file_selected.connect(_on_file_dialog_file_selected)
	file_dialog.dir_selected.connect(_on_file_dialog_dir_selected)
	
	Events.teleport_node_enter_requested.connect(_on_teleport_node_enter_requested)
	Events.teleport_node_exit_requested.connect(_on_teleport_node_exit_requested)
	Events.teleporter_add_requested.connect(_on_teleporter_add_requested)
	
	Events.connection_entry_select_requested.connect(_on_connection_entry_select_requested)
	Events.connection_entry_delete_requested.connect(_on_connection_entry_delete_requested)

func _process(_delta):
	$Container.visible = true
	$LeftUI.visible = true
	
	if StateAuth.active_authoring == StateAuth.ActiveAuthoring.Teleport:
		# Hide Event Author buttons
		for button: Button in get_tree().get_nodes_in_group("EventAuthorButtons"):
			button.visible = false
		for button: Button in get_tree().get_nodes_in_group("TeleportAuthorButtons"):
			button.visible = true
		
		# Add button rendering
		add_node_button.disabled = teleport_author.in_edit_node_mode or teleport_author.in_edit_connections_mode
		
		# Delete button rendering
		if teleport_author.child_selected() == null \
			or teleport_author.in_edit_connections_mode \
			or teleport_author.in_edit_node_mode:
			delete_node_button.disabled = true
		else:
			delete_node_button.disabled = false
		
		# Edit button rendering
		edit_connections_button.disabled = teleport_author.child_selected() == null or teleport_author.in_edit_node_mode
		edit_connections_button.text = "CONFIRM" if teleport_author.in_edit_connections_mode else "EDIT CONNECTIONS"
		
		# Enter button rendering
		enter_node_button.disabled = teleport_author.child_selected() == null or teleport_author.in_edit_connections_mode
		enter_node_button.text = "CONFIRM" if teleport_author.in_edit_node_mode else "ENTER NODE"
		
		# Connection list rendering
		entity_list.visible = teleport_author.in_edit_node_mode
		
		# Node viewer actions rendering
	#	if teleport_author.in_edit_node_mode: blablabla
	
	elif StateAuth.active_authoring == StateAuth.ActiveAuthoring.Event:
		# Hide Teleport Author buttons
		for button: Button in get_tree().get_nodes_in_group("TeleportAuthorButtons"):
			button.visible = false
		for button: Button in get_tree().get_nodes_in_group("EventAuthorButtons"):
			button.visible = true
	
	elif StateAuth.active_authoring == StateAuth.ActiveAuthoring.Demo:
		$Container.visible = false
		$LeftUI.visible = false

func update_entity_list(node: TeleportNode):
	if StateAuth.active_authoring == StateAuth.ActiveAuthoring.Teleport:
		var all_teleporters = node.teleport_spots + node.teleport_connections
		# Make number of connection entries equal the number of connections
		var difference = entity_list.get_child_count() - all_teleporters.size()
		if difference < 0:
			# Increase amount connection entries
			for i in range(abs(difference)):
				entity_list.add_child(connection_entry.instantiate())
		elif difference > 0:
			# Decrease amount of connection entries
			for i in range(abs(difference)):
				var node_to_remove = entity_list.get_child(0)
				entity_list.remove_child(node_to_remove)
				node_to_remove.queue_free()
		
		# By now, the number of connection entries and teleport connections are equal
		# Connect the entries to each teleport connection
		if entity_list.get_child_count() > 0:
			for i in range(entity_list.get_child_count()):
				var entry: ConnectionEntry = entity_list.get_child(i)
				
				var connection
				if all_teleporters[i] is NodePath:
					connection = all_teleporters[i]
					entry.connected_to = get_node(connection)
					for teleporter in node.teleporters:
						if teleporter.teleport_location == get_node(connection):
							entry.teleporter = teleporter
				else:
					connection = (all_teleporters[i] as Teleporter).global_position
					entry.label.text = str((all_teleporters[i] as Teleporter).global_position.round())
					entry.teleporter = all_teleporters[i]
				

# Focus first entry that has no teleporter or the first-most entry
func focus_default_connection_entry():
	if entity_list.get_child_count() > 0:
		var entry_without_teleporter: ConnectionEntry
		for connection in entity_list.get_children():
			if not (connection as ConnectionEntry).teleporter:
				entry_without_teleporter = connection
				break
		
		if entry_without_teleporter:
			focus_connection_entry(entry_without_teleporter)
		else:
			focus_connection_entry(entity_list.get_child(0))

func focus_connection_entry(entry: ConnectionEntry):
	for connection in entity_list.get_children():
		connection.focused = false
	
	var entry_to_focus: ConnectionEntry = entity_list.get_child(entity_list.get_children().find(entry))
	entry_to_focus.focused = true

func get_focused_connection_entry():
	for connection in entity_list.get_children():
		if connection.focused:
			return connection
	
	return null

# Open file dialog to add teleport node
func _on_add_node_button_pressed():
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	#file_dialog.current_dir = ProjectSettings.globalize_path("C:/Users/VAMR/Downloads/drive-download-20240411T035525Z-001")
	file_dialog.current_dir = ProjectSettings.globalize_path("res://")
	file_dialog.show()

func _on_file_dialog_file_selected(path: String):
	var teleport_node: TeleportNode = load("res://src/TeleportNode.tscn").instantiate()
	
	var filetype = path.get_extension()
	
	if filetype == "jpg":
		teleport_node.sprite_texture_filename = path
	elif filetype == "obj":
		teleport_node.mesh_filename = path
		(teleport_node.mesh) = load(path)
		
	teleport_node.area_name = path.get_file()

	var teleport_node_internal_filename = path.get_file().to_lower()
	var teleport_node_internal_name = teleport_node_internal_filename.get_slice("/", path.get_slice_count("/") - 1).replace(" ", "_")
	Events.teleport_node_add_requested.emit(teleport_node, teleport_node_internal_name)

func _on_file_dialog_dir_selected(path: String):
	project_title.text = path.get_file()
	Events.load_requested.emit(path)

func _on_delete_node_button_pressed():
	var selected_child: TeleportNode = teleport_author.child_selected()
	Events.teleport_node_delete_requested.emit(selected_child)

func _on_edit_connections_button_pressed():
	var selected_child: TeleportNode = teleport_author.child_selected()
	
	if teleport_author.in_edit_connections_mode:
		Events.teleport_node_edit_confirm_requested.emit(selected_child)
	else:
		Events.teleport_node_edit_requested.emit(selected_child)

func _on_demo_button_pressed():
	if StateAuth.active_authoring == StateAuth.ActiveAuthoring.Demo:
		Events.demo_exit_requested.emit()
		return
	
	var start_node: TeleportNode = teleport_author.child_selected()
	if not start_node:
		push_error("No teleport node selected.")
		return
	Events.demo_requested.emit(start_node)

func _on_switch_button_pressed():
	Events.switch_requested.emit()

# Enter or exit node
func _on_enter_node_button_pressed():
	var selected_child: TeleportNode = teleport_author.child_selected()
	
	if teleport_author.in_edit_node_mode:
		Events.teleport_node_exit_requested.emit(selected_child)
	else:
		Events.teleport_node_enter_requested.emit(selected_child)

func _on_export_button_pressed():
	Events.export_requested.emit()

func _on_save_button_pressed():
	save_button.text = "..."
	Events.save_requested.emit()
	await Signal(Events.save_finished)
	save_button.text = "SAVE"

func _on_load_button_pressed():
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	file_dialog.current_dir = ProjectSettings.globalize_path("user://")
	file_dialog.show()

func _on_teleport_node_enter_requested(node: TeleportNode):
	update_entity_list(node)
	focus_default_connection_entry()
	entity_list.visible = true

func _on_teleport_node_exit_requested(_node):
	for child in entity_list.get_children():
		child.queue_free()
	
	entity_list.visible = false

func _on_teleporter_add_requested(node: TeleportNode, pos: Vector3, rot: Vector3):
	var focused_entry = get_focused_connection_entry()
	if node.mesh:
		# If 3D scene
		if not focused_entry:
			# Meaning this should be a Teleporter
			var teleporter = teleporter_scene.instantiate()

			node.teleport_spots.append(teleporter)
			Events.teleporter_add_finished.emit(node, teleporter, pos, rot)
		elif focused_entry and (focused_entry as ConnectionEntry).connected_to and \
			not (focused_entry as ConnectionEntry).teleporter:
			# Meaning this should be a TeleporterOutsideConnection
			var teleporter = teleporter_oc_scene.instantiate()

			node.teleporters.append(teleporter)

			focused_entry.teleporter = teleporter
			focused_entry.teleporter.teleport_location = focused_entry.connected_to
			
			print(teleporter.global_position)
			Events.teleporter_add_finished.emit(node, teleporter, pos, rot)
		else:
			# Meaning this should be a Teleporter
			var teleporter = teleporter_scene.instantiate()

			node.teleport_spots.append(teleporter)
			Events.teleporter_add_finished.emit(node, teleporter, pos, rot)
	else:
		if not focused_entry:
			return
		# If 360 image scene
		if (focused_entry as ConnectionEntry).connected_to and \
			not (focused_entry as ConnectionEntry).teleporter:
			# Meaning this should be a TeleporterOutsideConnection
			var teleporter = teleporter_oc_scene.instantiate()
			teleporter.global_position = pos
			teleporter.global_rotation = rot

			node.teleporters.append(teleporter)

			focused_entry.teleporter = teleporter
			focused_entry.teleporter.teleport_location = focused_entry.connected_to
			
			print(teleporter.global_position)
			Events.teleporter_add_finished.emit(node, teleporter, pos, rot)
	
	update_entity_list(node)
	focus_default_connection_entry()

func _on_connection_entry_select_requested(entry: ConnectionEntry):
	focus_connection_entry(entry)

func _on_connection_entry_delete_requested(entry: ConnectionEntry):
	pass
