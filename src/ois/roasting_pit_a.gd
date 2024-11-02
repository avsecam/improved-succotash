extends StaticBody3D

@export var pole_visible : Node3D
var time : float
var progress_bool : bool
@onready var progress_view = $"Progress View"

func _physics_process(delta):
	if pole_visible.visible:
		time += delta
		if !progress_bool:
			_on_associated_event_finished_first_time()
		pole_visible.rotation_degrees.x += 30 * time
		pole_visible.rotation_degrees.y = 180
		pole_visible.rotation_degrees.z = 90
		pole_visible.position.x = 0
		pole_visible.position.y = 0.5
		pole_visible.position.z = 0

func _on_associated_event_finished():
	pole_visible.visible = true
	progress_bool = true
	
func _on_associated_event_finished_first_time():
	progress_view.visible = true
	progress_view.progress_complete_checkmark_only_anim()
