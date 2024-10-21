extends StaticBody3D

@export var pole_visible : Node3D
var time : float
var progress_bool : bool
@onready var progress_view = $"Progress View"

func _physics_process(delta):
	if pole_visible.visible:
		if !progress_bool:
			progress_view.visible = true
			progress_view.progress_complete_checkmark_only_anim()
			progress_bool = true
		time += delta
		pole_visible.rotation_degrees.x += 30 * time
		pole_visible.rotation_degrees.y = 180
		pole_visible.rotation_degrees.z = 90
		pole_visible.position.x = 0
		pole_visible.position.y = 0.5
		pole_visible.position.z = 0
