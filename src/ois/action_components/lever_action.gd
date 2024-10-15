extends ReceiverObj
class_name LeverAction

var initial_direction
var past_progress = 0

var init_direction2
var action_comp_origin2
var init_handle_pos2
var curr_handle_pos2
var delta_angle_buffer2 = 0
var total_progress2 = 0
var past_progress2 = 0

func initialize_action_vars():
	initial_direction = interacting_object.position-position
	past_progress = total_progress
	
	delta_angle_buffer2 = 0
	action_comp_origin2 = position
	init_handle_pos2 = interacting_object.position
	init_direction2 = init_handle_pos2-action_comp_origin2
	init_direction2.x = 0
	past_progress2 = total_progress2
	set_process(true)


func _process(delta):
	var curr_direction = interacting_object.position-position 
	
	var axis = Vector3(0, 0, 1)
	var current_progress = initial_direction.signed_angle_to(curr_direction, axis)
	
	total_progress = past_progress + (current_progress * rate);
	print(total_progress)
	super(delta)
