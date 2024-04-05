extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_teleport_requested_trigger", _on_player_teleport_requested)

func _on_player_teleport_requested(new_level_filepath: String):
	get_child(0).queue_free()
	var new_level = load("res://src/areas/" + new_level_filepath + ".tscn").instantiate()
	add_child(new_level)
