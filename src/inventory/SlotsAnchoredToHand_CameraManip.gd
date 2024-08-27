extends Node3D


@export var camera : XRCamera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var point = camera.global_transform.origin
	self.look_at(point, Vector3.UP)	
	#self.rotation.y= lerp_angle(self.rotation.y, atan2(-direction.x,-direction.z),.9)
	#


#func _look_at_target_interpolated(weight:float) -> void:
	#var point = camera.global_transform.origin
	#var xform = self
	#self.look_at(point,Vector3.UP)
	#self.transform.interpolate_with(xform.transform,weight)
