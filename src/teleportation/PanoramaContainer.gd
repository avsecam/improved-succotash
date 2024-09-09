extends Node3D

@onready var controller := XRHelpers.get_right_controller(%XRPlayer)
@onready var camera := XRHelpers.get_xr_camera(%XRPlayer)
@onready var origin := XRHelpers.get_xr_origin(%XRPlayer)

@onready var nonvr := %NonVR

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("player_teleport_requested_trigger", _on_player_teleport_requested)
	Events.connect("non_vr_teleporter_clicked", _on_non_vr_teleporter_clicked)
	
	Events.connect("xr_camera_moved", _on_xr_camera_moved)
	
	# res://src/areas/<area_name>.tscn
	var start_scene = preload("res://src/areas/tut1.jpg.tscn").instantiate()
	add_child(start_scene)

func _on_player_teleport_requested(teleporter: Teleporter):
	if teleporter.to:
		var new_level_filepath = teleporter.to
		var new_level: Level = load("res://src/areas/" + new_level_filepath + ".tscn").instantiate()
		self.rotation.y = new_level.base_rotation

		get_child(0).queue_free()
		add_child(new_level)
	
		if new_level is ThreeDScene:
			# Set player position to the first teleport_spot
			var first_teleport_spot: Dictionary
			for i in new_level.teleporters_data.size():
				if new_level.teleporters_data[i].get("to") == null:
					first_teleport_spot = new_level.teleporters_data[i]
			origin.position = first_teleport_spot.position
			origin.position.y = 1.7
		else:
			origin.position = Vector3()
			origin.position.y = -0.65
	else:
		if get_child(0) is Panorama:
			return
		else:
			# Teleport to the position of the teleporter
			origin.position = teleporter.position
			origin.position.y = 1.7
			print(origin.global_position)

func _on_non_vr_teleporter_clicked(teleporter: Teleporter):
	self.position.y = 0
	if teleporter.to:
		var new_level: Level = load("res://src/areas/" + teleporter.to + ".tscn").instantiate()
		
		get_child(0).queue_free()
		self.rotation.y = new_level.base_rotation
		add_child(new_level)
		
		if new_level is ThreeDScene:
			# Set player position to the first teleport_spot
			var first_teleport_spot: Dictionary
			for i in new_level.teleporters_data.size():
				if new_level.teleporters_data[i].get("to") == null:
					first_teleport_spot = new_level.teleporters_data[i]
			nonvr.position = first_teleport_spot.position
			nonvr.position.y = 1.7
		else:
			nonvr.position = Vector3()
	else:
		if get_child(0) is Panorama:
			printerr("Teleporter has no set teleport location.")
			return
		else:
			nonvr.position = teleporter.position
			nonvr.position.y = 1.7
	

func _on_xr_camera_moved(pos, rot):
	if get_child_count() > 0:
		if get_child(0) is Panorama:
			(get_child(0) as Panorama).global_position = pos

func set_scene(full_filepath : String):
	get_child(0).queue_free()
	var new_level: Panorama = load(full_filepath).instantiate()
	self.rotation.y = new_level.base_rotation
	add_child(new_level)
	return new_level
