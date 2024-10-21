extends AnimatedSprite3D

@export var associated_event : String

var camera
var lock_rotate
var already_read := false
# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_indicator.call_deferred()
	check_if_read.call_deferred()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cam_pos = camera.global_position
	look_at(cam_pos, Vector3.UP)
	rotate_object_local(Vector3.UP, PI)

func initialize_indicator() -> void:
	if Events.current_mode == "NonVR":
		camera = get_tree().get_root().get_node("Demo/NonVR/Camera")
		print(camera.name)
	elif Events.current_mode == "VR":
		camera = get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/XRCamera3D")
		print(camera.name)
		
		lock_rotate = get_parent().get_parent().global_rotation.y


func check_if_read() -> void:
	if (associated_event + "_Read") in Events.finished_events:
		already_read = true
	else:
		already_read = false
	change_animation(already_read)


func change_animation(b: bool) -> void:
	if b:
		play("done")
	else:
		play("not_done")


func _on_events_rechecking_events():
	check_if_read()
