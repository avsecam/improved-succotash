extends Feedback

@export var kalabasaa : Node3D
@export var kalabasab : Node3D
@export var kalabasac : Node3D
@export var kalabasad : Node3D


func _on_kalabasa_receiver_action_in_progress(requirement, total_progress):
	
	var percentage = total_progress/requirement
	print("Kalabasa chop progress: " + str(percentage*100)+"%")
	
	if percentage < 0.25:
		kalabasaa.visible = true
		kalabasab.visible = false
		kalabasac.visible = false
	elif percentage >= 0.3 and percentage < 0.6:
		kalabasaa.visible = false
		kalabasab.visible = true
		kalabasac.visible = false
	elif percentage >= 0.6 and percentage < 1:
		kalabasaa.visible = false
		kalabasab.visible = false
		kalabasac.visible = true
		
func _on_kalabasa_receiver_action_completed(requirement, total_progress):
		kalabasaa.visible = false
		kalabasab.visible = false
		kalabasac.visible = false
		kalabasad.visible = true
