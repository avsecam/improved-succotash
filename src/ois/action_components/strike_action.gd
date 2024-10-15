extends ReceiverObj

var interacting_inital_pos
var hit_already = false
@export var range = 1
var actor_receiver_dist_init
var time_start

func initialize_action_vars():
	interacting_inital_pos = interacting_object.position
	actor_receiver_dist_init = position.distance_to(interacting_inital_pos)
	hit_already = false
	time_start = Time.get_ticks_usec()

func _process(delta):
	var interacting_current_pos = interacting_object.position
	var actor_receiver_dist = position.distance_to(interacting_current_pos)
	var actor_start_end_dist = interacting_inital_pos.distance_to(interacting_current_pos)
	#print("dist : " + str(actor_receiver_dist))

	# hasn't registred hit yet, actor and receiver within range, direction of motion is towards the object
	if(!hit_already && actor_receiver_dist < range && actor_receiver_dist < actor_receiver_dist_init):
		var time_end = Time.get_ticks_usec()
		var time_total = (time_end - time_start)/1000 #get total time in seconds
		var current_progress = actor_start_end_dist/time_total #results in meters/second
		total_progress += (current_progress * rate)
		hit_already = true
		print("total progress: " + str(total_progress))
		print(str(actor_start_end_dist) + " / " + str(time_total) + " = " + str(current_progress))
		super(delta)
