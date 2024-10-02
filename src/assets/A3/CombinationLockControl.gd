extends XRToolsInteractableArea


@onready var interface := $CombinationLockInterface


@export var object_follow_speed := 4.0
@export var object_distance := 0.75
@export var object_height : float 

var camera
var lock_rotate
var trying_lock = false

func _ready() -> void:
	call_deferred("initialize_lock")

func initialize_lock() -> void:
	print(Events.current_mode)
	if Events.current_mode == "NonVR":
		camera = get_tree().get_root().get_node("Demo/NonVR/Camera")
		print(camera.name)
	elif Events.current_mode == "VR":
		camera = get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/XRCamera3D")
		print(camera.name)
		
		lock_rotate = interface.get_parent().get_parent().global_rotation.y

func _physics_process(delta):
	if trying_lock:
		var point = camera.global_transform.origin
		#interface.look_at(-point)	
		
		var temp_pos = interface.position
		
		##deg_to_rad(camera.global_rotation_degrees.y)
		
		var position_x_rotate = object_distance * cos(camera.global_rotation.y - interface.get_parent().get_parent().global_rotation.y)
		var position_z_rotate = object_distance * sin(camera.global_rotation.y - interface.get_parent().get_parent().global_rotation.y)
		var position_ui_offset = Vector3(-position_z_rotate,object_height,-position_x_rotate)
		interface.global_transform.origin = interface.global_transform.origin.lerp(camera.global_transform.origin + position_ui_offset, delta * object_follow_speed)
		
		interface.rotation.y = camera.global_rotation.y - interface.get_parent().get_parent().global_rotation.y - 0.3
	#print("Dialogue UI POSITION:"+str(self.transform.origin))
	#print("CAMERA GLOBALTRANSFORM:"+str(point))


func activate_lock() -> void:
	interface.lock_active(true)
	interface.visible = true
	trying_lock = true


func deactivate_lock() -> void:
	interface.lock_active(false)
	interface.visible = false
	trying_lock = false


func _on_visible_on_screen_notifier_3d_screen_exited():
	deactivate_lock()


func _on_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if !trying_lock:
			activate_lock()
		elif trying_lock:
			deactivate_lock()


func _on_combination_lock_interface_lock_solved():
	queue_free()
