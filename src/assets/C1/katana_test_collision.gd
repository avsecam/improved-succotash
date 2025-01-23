extends XRToolsPickable

@onready var distortion_crystal = $"../DistortionCrystal/Crystal_Collider"
@onready var distortion_crystal_2 = $"../DistortionCrystal2"
@onready var distortion_crystal_3 = $"../DistortionCrystal3"

func _on_body_entered(body):
	if body == distortion_crystal:
		print("colliding with 1")
	if body == distortion_crystal_2:
		print("colliding with 2")
	if body == distortion_crystal_3:
		print("colliding with 3")
