extends ReceiverObj
class_name StrikeAction

var interacting_inital_pos
var hit_already = false
@export var range = 1
var actor_receiver_dist_init
var time_start

func initialize_action_vars():
	interacting_inital_pos = interacting_object.global_position
	actor_receiver_dist_init = global_position.distance_to(interacting_inital_pos)
	hit_already = false
	time_start = Time.get_ticks_usec()

func _process(delta):
	var interacting_current_pos = interacting_object.global_position
	var actor_receiver_dist = global_position.distance_to(interacting_current_pos)
	var actor_start_end_dist = interacting_inital_pos.distance_to(interacting_current_pos)
	#print("dist : " + str(actor_receiver_dist))(:[a:

	# hasn't registred hit yet, actor and receiver within range, direction of motion is towards the object
	print("Hit Already: " + str(hit_already))
	print("Actor receiver < range: " + str(actor_receiver_dist < range))
	print("Actor reciever dist < Actor reciever init: " + str(actor_receiver_dist < actor_receiver_dist_init))
	
	print(actor_receiver_dist)
	print(actor_receiver_dist_init)
	print(range)
	if(!hit_already && actor_receiver_dist < range && actor_receiver_dist < actor_receiver_dist_init):
		var time_end = Time.get_ticks_usec()
		var time_total = (time_end - time_start)/1000 #get total time in seconds
		var current_progress = actor_start_end_dist/time_total #results in meters/second
		total_progress += (current_progress * rate)
		hit_already = true
		print("total progress: " + str(total_progress))
		print(str(actor_start_end_dist) + " / " + str(time_total) + " = " + str(current_progress))
		super(delta)
