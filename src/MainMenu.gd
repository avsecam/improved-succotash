extends Node3D

var camera

@export var object_follow_speed := 4.0
@export var object_distance := 0.75
@export var object_height : float 
var image_rotate

@onready var quest_tracker_ui := $"Viewport2Din3D/Viewport/StaticUI/QuestTrackerUI"
@onready var dialogue_box := $"Viewport2Din3D/Viewport/StaticUI/Dialogue UI"

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(camera.name)
	pass # Replace with function body.

func initialize_main_menu_container(mode: String) -> void:
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
	var position_ui_offset = Vector3(-position_z_rotate,object_height,-position_x_rotate)
	self.global_transform.origin = self.global_transform.origin.lerp(camera.global_transform.origin + position_ui_offset, delta * object_follow_speed)
	
	self.rotation.y = camera.global_rotation.y - self.get_parent().global_rotation.y
	#print("Dialogue UI POSITION:"+str(self.transform.origin))
	#print("CAMERA GLOBALTRANSFORM:"+str(point))
