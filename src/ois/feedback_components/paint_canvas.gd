extends Feedback

@export var canvas_blank : Node3D
@export var canvas_ahrt: Node3D
@export var interact_area_hitbox : Node3D

func show_feedback(requirement, total_progress):
	pass

func _on_canvas_paint_action_ended(requirement, total_progress):
	canvas_blank.visible = false
	canvas_ahrt.visible = true
	interact_area_hitbox.disabled = false
	print("INTERACT AREA FOR PAINTING ENABLED")
