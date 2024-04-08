@tool
extends CollisionObject3D
class_name ReceiverObj

@export var requirement : float
var interacting_object
var total_progress = 0
var rate = 0

signal action_performed(requirement, total_progress)
# signal action_completed

func _ready():
	set_process(false)
	# connect signal to feedback nodes
	for i in get_children():
		if i is Feedback:
			action_performed.connect(i.show_feedback)

# start checking action
func start_action_check(state_manager, rate):
	self.rate = rate
	if (rate == 0):
		set_process(false)
		interacting_object = null
	else:
		set_process(true)
		interacting_object = state_manager.actor_object
		initialize_action_vars()

# set which variables to initialize at the start of an action (during start_action_check)
func initialize_action_vars():
	pass

# contains calculation of motion (if is appropriate to defined action)
func _process(delta):
	pass

func check_if_completed():
	if (requirement > 0 && total_progress >= requirement || requirement < 0 && total_progress <= requirement):
		print("completed")
		# action_completed.emit()
		return true
#
#func _get_configuration_warnings():
	#var warnings = []
#
	#var collision_object = null
	#for i in get_children():
		#if i is CollisionObject3D:
			#collision_object = i
			#break
	#
	#if collision_object == null:
		#warnings.append("Add a CollisionObject3D (e.g., Area3D, Rigidbody3D, StaticBody3D)")
#
	## Returning an empty array means "no warning".
	#return warnings
