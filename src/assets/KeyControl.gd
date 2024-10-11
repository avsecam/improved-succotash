extends Node3D

@onready var key := get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	activate_key.call_deferred()


func activate_key() -> void:
	if Events.finished_events.has("DialogueGateIsLocked_Done"):
		key.visible = true
		key.enabled = true
	else:
		key.visible = false
		key.enabled = false
