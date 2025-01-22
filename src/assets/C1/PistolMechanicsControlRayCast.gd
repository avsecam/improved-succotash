extends SBRaycast

@onready var crystal_collider = $DistortionCrystal4/Crystal_Collider

func _ready():
	pass # Replace with function body.

func _process(delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider != null and crystal_collider != null:
			if collider.name == crystal_collider.name:
				print("Collided with: ", collider.name)
