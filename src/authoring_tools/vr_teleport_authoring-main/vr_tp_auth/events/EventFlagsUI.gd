extends Control

const EVENT_FLAGS = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/events/EventFlags.tscn")
const LOCKS_SETTER = preload("res://src/authoring_tools/vr_teleport_authoring-main/vr_tp_auth/events/LocksSetter.tscn")

func _ready():
	$EventFlagsButton.pressed.connect(_on_EventFlagsButton_pressed)
	Events.event_flags_toggle_requested.connect(_on_event_flags_toggle_requested)
	
	Events.locks_toggle_requested.connect(_on_locks_toggle_requested)

func _on_EventFlagsButton_pressed():
	Events.event_flags_toggle_requested.emit()

func _on_event_flags_toggle_requested():
	var event_flags_window = find_child("EventFlags")
	if event_flags_window:
		event_flags_window.queue_free()
	else:
		var ui = EVENT_FLAGS.instantiate()
		add_child(ui)

func _on_locks_toggle_requested(teleporter: Teleporter):
	var existing_locks_setter = get_tree().get_nodes_in_group("LocksSetter")
	if existing_locks_setter.size() > 0:
		remove_child(existing_locks_setter[0])
		existing_locks_setter[0].queue_free()
	
	var locks_setter_instance = LOCKS_SETTER.instantiate()
	locks_setter_instance.teleporter = teleporter
	add_child(locks_setter_instance)
