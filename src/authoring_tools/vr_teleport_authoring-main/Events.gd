extends Node

# This script contains all the signals that are used to communicate between the different parts of the application.

# Teleport Author
signal teleport_node_selected(node: TeleportNode)
signal teleport_node_drag_started(node: TeleportNode)
signal teleport_node_add_requested(node: TeleportNode, internal_name: String)
signal teleport_node_delete_requested(node: TeleportNode)
signal teleport_node_edit_requested(node: TeleportNode)
signal teleport_node_edit_confirm_requested(node: TeleportNode)
signal teleport_node_connection_add_requested(to: TeleportNode)

signal teleport_node_enter_requested(node: TeleportNode)
signal teleport_node_exit_requested(node: TeleportNode)
signal teleporter_add_requested(node: TeleportNode, pos: Vector3, rot: Vector3)
signal teleporter_add_finished(node: TeleportNode, teleporter: TeleporterAuth, pos: Vector3, rot: Vector3)

signal connection_entry_select_requested(entry: ConnectionEntry)
signal connection_entry_delete_requested(entry: ConnectionEntry)

# Event Author
signal event_flags_toggle_requested()
signal locks_toggle_requested(teleporter: TeleporterAuth)

signal trigger_add_requested(trigger_name: String)
signal trigger_add_confirmed(trigger_name: String)
signal trigger_delete_requested(trigger_name: String)
signal trigger_delete_confirmed(trigger_name: String)
signal trigger_toggle_requested(trigger_name: String)
signal trigger_set_requested(trigger_name: String, value: bool)

signal trigger_toggle_connection_requested(trigger_name: String, teleporter: TeleporterAuth)

# Demo
signal demo_requested(start_node: TeleportNode)
signal demo_exit_requested()

signal teleport_requested(to: TeleportNode)

# Common
signal switch_requested()

signal export_requested()
signal save_requested()
signal save_finished()
signal load_requested(file_path: String)
