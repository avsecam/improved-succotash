extends ReceiverObj
class_name WipeAction

var interacting_inital_pos
var delta_dist_prev = 0
var total_delta_dist = 0
var buffer = 0.005
var past_progress = 0

func initialize_action_vars():
	interacting_inital_pos = interacting_object.position
	past_progress = total_progress
	
	delta_dist_prev = 0
	total_delta_dist = 0

func _process(_delta):
	var interacting_current_pos = interacting_object.position
	
	var delta_dist = interacting_inital_pos.distance_to(interacting_current_pos)
	#print(str(interacting_inital_pos) + " - " + str(interacting_current_pos) + " = " + str(delta_dist))
	var current_progress = total_delta_dist + delta_dist
		
	if(delta_dist < (delta_dist_prev-buffer)):
		total_delta_dist += delta_dist
		interacting_inital_pos = interacting_object.position
	
	delta_dist_prev = delta_dist
	
	total_progress = past_progress + (current_progress * rate);
	print(total_progress)
	
	super(_delta)
