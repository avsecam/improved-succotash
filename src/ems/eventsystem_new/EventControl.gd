extends Node

@onready var teleporters = get_parent().get_node("Teleporters")

func _ready() -> void:
	call_deferred("check_waypoints")


func check_waypoints() -> void:
	for child in teleporters.get_children():
		if child.name in Events.locked_teleporters:
			if Events.locked_teleporters[child.name] in Events.finished_events:
				child.enable_teleporter()
				print("enabled " + child.name)
			else:
				child.enabled = false
				print("disabled " + child.name)


func _on_event_ended() -> void:
	await get_tree().create_timer(0.1).timeout
	check_waypoints()
	for child in get_children():
		if not child.is_ongoing:
			child.start_event()
