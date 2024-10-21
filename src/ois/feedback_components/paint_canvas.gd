extends Feedback

@export var canvas_blank : Node3D
@export var canvas_ahrt: Node3D
@onready var progress_view = $"../Progress View"

var anim_check : bool


func show_feedback(requirement, total_progress):
	pass


func _on_canvas_paint_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	print("Paint progress: " + str(percentage*100)+"%")
	progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	
	if percentage >= 1:
		if !anim_check:
			canvas_blank.visible = false
			canvas_ahrt.visible = true
			progress_view.progress_complete_anim()
			anim_check = true
		
