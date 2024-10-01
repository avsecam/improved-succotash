@tool
extends StateManager
class_name SMOneHandedTool

@onready var idle_state = $IdleState
@onready var active_state = $ActiveState
@onready var trigger_state = $TriggerState
@onready var active_colliding_state = $ActiveCollidingState

@onready var actor_object = get_parent()

var a = func(x): if (x == "trigger_click"): _on_trigger_pressed()
var b = func(x): if (x == "trigger_click"): _on_trigger_released()

func _ready():
	super()
	actor_object.grabbed.connect(_on_actor_object_grabbed)
	actor_object.released.connect(_on_actor_object_released)

func _on_actor_object_released(pickable, by):
	if by is XRToolsFunctionPickup:
		var controller : XRController3D = by.get_controller()
		controller.button_pressed.disconnect(a)
		controller.button_released.disconnect(b)
		
		var controller_sm = controller.get_node_or_null("StateManager")
		if controller_sm != null:
			controller_sm._on_object_released()

		set_state(idle_state)

func _on_actor_object_grabbed(pickable, by):
	if by is XRToolsFunctionPickup:
		var controller : XRController3D = by.get_controller()
		controller.button_pressed.connect(a)
		controller.button_released.connect(b)
		
		var controller_sm = controller.get_node_or_null("StateManager")
		if controller_sm != null:
			controller_sm._on_object_grabbed()

		set_state(active_state)
	
func _on_trigger_pressed():
	if (receiver_object != null):
		set_state(trigger_state)

	# other option
	# set_state(trigger_state)
		# have state check if receiver exists?
		# or make another state trigger w/o obj

func _on_trigger_released():
	if (current_state == trigger_state):
		receiver_object = null
		set_state(active_state)

func _on_receiver_collision_entered(receiver):
	if is_instance_valid(receiver):
		print("collision " + receiver.name)
		if receiver.is_in_group(receiver_group):
			receiver_object = receiver
			set_state(active_colliding_state)
		else:
			for child in receiver.get_children():
				if child.is_in_group(receiver_group):
					receiver_object = child
					set_state(active_colliding_state)
					break


func _on_receiver_collision_exited(receiver):
	if (current_state == active_colliding_state):
		receiver_object = null
		set_state(active_state)
