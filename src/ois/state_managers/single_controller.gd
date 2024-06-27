@tool
extends StateManager
class_name SingleControllerSM

var controller : XRController3D

@onready var idle_state = $IdleState
@onready var active_state = $ActiveState
@onready var active_colliding_state = $ActiveCollidingState
@onready var trigger_state = $TriggerState

@onready var actor_object = get_parent()

var is_colliding = false

signal change_state(state_manager, state)
signal body_entered(state_manager, body)
signal body_exited(state_manager, body)

func _ready():
	super()
	controller = get_parent()
	if controller != null:
		controller.button_pressed.connect(func(x): if (x == "trigger_click"): _on_trigger_pressed())
		controller.button_released.connect(func(x): if (x == "trigger_click"): _on_trigger_released())

func set_state(state : OISState):
	super(state)
	change_state.emit(self, state)

# triggered by object state managers
func _on_object_released():
	set_state(active_state)

# triggered by object state managers
func _on_object_grabbed():
	set_state(idle_state)
	
func _on_trigger_pressed():
	if current_state == active_colliding_state:
		set_state(trigger_state)

func _on_trigger_released():
	if (current_state == trigger_state):
		if is_colliding:
			set_state(active_colliding_state)
		else:
			set_state(active_state)

func _on_receiver_collision_entered(receiver):
	is_colliding = true
	body_entered.emit(self, receiver)
	
	if (current_state == active_state):
		if receiver.is_in_group(receiver_group):
			receiver_object = receiver
			set_state(active_colliding_state)

func _on_receiver_collision_exited(receiver):
	# To make interaction reqs less strenous, don't automatically transition out of interacting state
	# when collision is exited (as it may be difficult for users to remain precision)
	# Instead, keep track whether it is colliding so that upon next transition, can act accordingly
	is_colliding = false
	body_exited.emit(self, receiver)
	
	if (current_state == active_colliding_state):
		if receiver.is_in_group(receiver_group):
			receiver_object = null
			set_state(active_state)
