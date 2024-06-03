extends ReceiverObj

@export var reference_point : Node3D
@export var req_is_init_dist : bool = false
var past_progress = 0
var initial_distance

func _ready():
	super()
	if req_is_init_dist:
		requirement = global_position.distance_to(reference_point.global_position)

func initialize_action_vars():
	initial_distance = interacting_object.position.distance_to(reference_point.position)
	past_progress = total_progress
	
func _process(delta):
	var curr_distance = interacting_object.position.distance_to(reference_point.position)
	var current_progress = initial_distance-curr_distance
	total_progress = past_progress + (current_progress * rate)
	$Label3D.set_text("req: %s\ncurr: %s\ntotal: %s" % [requirement, current_progress, total_progress])
	
	super(delta)
