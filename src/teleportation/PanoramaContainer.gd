extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_teleport_requested_trigger", _on_player_teleport_requested)
	
	# res://src/areas/<area_name>.tscn
	var start_scene = preload("res://src/areas/Tut1.jpg.tscn").instantiate()
	add_child(start_scene)

func _on_player_teleport_requested(new_level_filepath: String):
	get_child(0).queue_free()
	var new_level: Panorama = load("res://src/areas/" + new_level_filepath + ".tscn").instantiate()
	self.rotation.y = new_level.base_rotation
	add_child(new_level)

func set_scene(full_filepath : String):
	get_child(0).queue_free()
	var new_level: Panorama = load(full_filepath).instantiate()
	self.rotation.y = new_level.base_rotation
	add_child(new_level)
	return new_level
