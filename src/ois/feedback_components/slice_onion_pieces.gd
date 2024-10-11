extends Feedback

@export var oniona : Node3D
@export var onionb : Node3D
@export var onionc : Node3D
@export var oniond : Node3D

func _on_onion_receiver_action_in_progress(requirement, total_progress):
	
	var percentage = total_progress/requirement
	print("Onion chop progress: " + str(percentage*100)+"%")
	
	if percentage < 0.25:
		oniona.visible = true
		onionb.visible = false
		onionc.visible = false
	elif percentage >= 0.3 and percentage < 0.6:
		oniona.visible = false
		onionb.visible = true
		onionc.visible = false
	elif percentage >= 0.6 and percentage < 1:
		oniona.visible = false
		onionb.visible = false
		onionc.visible = true
		
func _on_onion_receiver_action_completed(requirement, total_progress):
		oniona.visible = false
		onionb.visible = false
		onionc.visible = false
		oniond.visible = true
