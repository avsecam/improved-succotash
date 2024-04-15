extends StateManager

@onready var idle_state = $IdleState
@onready var grab_state = $GrabState
@onready var trigger_state = $TriggerState
@onready var inventory_state = $InventoryState

@onready var actor_object = get_parent()

var a = func(x): if (x == "trigger_click"): _on_trigger_pressed()
var b = func(x): if (x == "trigger_click"): _on_trigger_released()

var triggered = false

func add_to_inventory():
	set_state(inventory_state)

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
		
		triggered = false
		set_state(grab_state)
	
func _on_trigger_pressed():
	# toggle trigger
	#if triggered:
		#triggered = false
	#else:
		#triggered = true
	#
	#if (receiver_object != null && triggered):
		#set_state(trigger_state)
	#else:
		#set_state(grab_state)
		
	if (receiver_object != null):
		set_state(trigger_state)

	# other option
	# set_state(trigger_state)
		# have state check if receiver exists?
		# or make another state trigger w/o obj

func _on_trigger_released():
	if (current_state == trigger_state):
		receiver_object = null
		set_state(grab_state)

func _on_receiver_collision_entered(receiver):
	if receiver.is_in_group(receiver_group):
		receiver_object = receiver
		set_state(current_state)

func _on_receiver_collision_exited(receiver):
	if (current_state == grab_state):
		receiver_object = null
		set_state(grab_state)
