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
	var result := space_state.intersect_ray(query)

	var collider: Node3D = result.get("collider")
	if collider:
		Events.non_vr_teleporter_hovered.emit(collider)
	else:
		Events.non_vr_no_teleporter_hovered.emit()
