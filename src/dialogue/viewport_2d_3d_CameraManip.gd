extends "res://addons/godot-xr-tools/objects/viewport_2d_in_3d.gd"

@export var camera : XRCamera3D
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	super._ready()
	
func _physics_process(delta):
	var point = camera.global_transform.origin
	self.look_at(point, Vector3.UP)	
	
