extends Node3D


@onready var camera: Camera3D = $Camera


func _ready():
	Events.start_with_vr.connect(_on_start_with_vr)
	Events.start_without_vr.connect(_on_start_without_vr)

func _on_start_with_vr():
	print("Freeing NonVR scene...")
	self.queue_free()

func _on_start_without_vr():
	return

func _physics_process(delta):
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
		Events.non_vr_teleporter_hovered.emit(collider)
		
		if Input.is_action_just_pressed("mouse_left") and collider.enabled:
			Events.player_teleport_requested_trigger.emit(collider.to)
	else:
		Events.non_vr_no_teleporter_hovered.emit()
