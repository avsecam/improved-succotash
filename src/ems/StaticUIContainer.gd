extends Node3D

var camera

@export var object_follow_speed := 10
@export var object_distance := 0.8
@export var object_height : float 
var image_rotate

@export var position_ui_offset : Vector3

var rotate_camera_by_controller : bool = false
@onready var quest_tracker_ui := $"Viewport2Din3D/Viewport/StaticUI/QuestTrackerUI"
@onready var dialogue_box := $"Viewport2Din3D/Viewport/StaticUI/Dialogue UI"
@onready var screen := $Viewport2Din3D/Screen

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(camera.name)
	pass # Replace with function body.
	screen.get_surface_override_material(0).set_flag(0, true)

func initialize_static_ui_container(mode: String) -> void:
	if mode == "NonVR":
		camera = get_tree().get_root().get_node("Demo/NonVR/Camera")
		print(camera.name)
	elif mode == "VR":
		camera = get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D/XRCamera3D")
		if self.get_node("Viewport2Din3D/Viewport").get_child(1) != null:
			self.get_node("Viewport2Din3D/Viewport").get_child(1).visible = false
		print(camera.name)
		
		image_rotate = self.get_parent().global_rotation.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	var point = camera.global_transform.origin
	#self.look_at(-point)	
	
	var temp_pos = self.position
	
	##deg_to_rad(camera.global_rotation_degrees.y)
	
	var position_x_rotate = object_distance * cos(camera.global_rotation.y - self.get_parent().global_rotation.y)
	var position_z_rotate = object_distance * sin(camera.global_rotation.y - self.get_parent().global_rotation.y)
	position_ui_offset = Vector3(-position_z_rotate,object_height/2,-position_x_rotate)
	
	if rotate_camera_by_controller:
		self.global_transform.origin = camera.global_transform.origin + 2*position_ui_offset
		self.rotation.y = camera.global_rotation.y - self.get_parent().global_rotation.y
		rotate_camera_by_controller = false
	else:
		self.global_transform.origin = self.global_transform.origin.lerp(camera.global_transform.origin + 2*position_ui_offset, delta * object_follow_speed)
		self.rotation.y = camera.global_rotation.y - self.get_parent().global_rotation.y
		self.rotation.x = 0
		self.rotation.z = 0
	#print("Dialogue UI POSITION:"+str(self.transform.origin))
	#print("CAMERA GLOBALTRANSFORM:"+str(point))


func _on_rotate_camera_rotate_camera_called():
	rotate_camera_by_controller = true
