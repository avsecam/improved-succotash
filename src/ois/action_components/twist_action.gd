extends ReceiverObj
class_name TwistAction

var interacting_inital_angle
var delta_angle_buffer
var past_progress = 0

func initialize_action_vars():
	interacting_inital_angle = interacting_object.basis.get_euler().z
	past_progress = total_progress
	delta_angle_buffer = 0

func _process(delta):
	var interacting_current_angle = interacting_object.basis.get_euler().z
	# print(name + ": " +  interacting_object.name + " " + str(interacting_inital_angle) + " " + str(interacting_current_angle))
	
	var delta_angle = interacting_current_angle-interacting_inital_angle
	# get shortest angle between two angles
	if (delta_angle > PI || delta_angle < -PI):
		delta_angle = sign(delta_angle)*(abs(delta_angle)-(2*PI))
		
	var current_progress = delta_angle_buffer + delta_angle
	
	# calculate twisting action when rotation is above 180/below -180
	if delta_angle >= 3:
		delta_angle_buffer += 3
		interacting_inital_angle = interacting_current_angle
	elif delta_angle <= -3:
		delta_angle_buffer -= 3
		interacting_inital_angle = interacting_current_angle
	
	total_progress = past_progress + (current_progress * rate);
	print(total_progress)
	super(delta)
