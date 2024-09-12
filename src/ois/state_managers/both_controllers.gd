@tool
extends StateManager

var single_controller_sm_scene = preload("res://src/ois/state_managers/single_controller.tscn")

@export var left_sm : SingleControllerSM
@export var right_sm : SingleControllerSM

var colliding_sm = []

@onready var idle_state = $IdleState
@onready var active_colliding1_state = $ActiveColliding1State
@onready var active_colliding2_state = $ActiveColliding2State
@onready var active_colliding1_trigger_state = $ActiveColliding1TriggerState
@onready var trigger1_state = $Trigger1State
@onready var trigger2_state = $Trigger2State

@onready var actor_object = self

func _ready():
	super()
	if left_sm != null:
		await left_sm.ready
		left_sm.body_entered.connect(_on_receiver_collision_entered)
		left_sm.body_exited.connect(_on_receiver_collision_exited)
		left_sm.controller.button_pressed.connect(func(x): if (x == "trigger_click"): _on_trigger_pressed())
		left_sm.controller.button_released.connect(func(x): if (x == "trigger_click"): _on_trigger_released())

	if right_sm != null:
		await right_sm.ready
		right_sm.body_entered.connect(_on_receiver_collision_entered)
		right_sm.body_exited.connect(_on_receiver_collision_exited)
		right_sm.controller.button_pressed.connect(func(x): if (x == "trigger_click"): _on_trigger_pressed())
		right_sm.controller.button_released.connect(func(x): if (x == "trigger_click"): _on_trigger_released())

func manage_single_controllers(state_manager, state):
	if state.state_name == "IdleState":
		set_state(idle_state)

func _on_trigger_pressed():
	if current_state == active_colliding1_state:
		set_state(active_colliding1_trigger_state)
	elif current_state == active_colliding2_state:
		set_state(trigger1_state)
	elif current_state == trigger1_state:
		set_state(trigger2_state)

func _on_trigger_released():
	if current_state == trigger2_state:
		set_state(trigger1_state)
	elif current_state == trigger1_state:
		set_state(active_colliding2_state)
	elif current_state == active_colliding1_trigger_state:
		set_state(active_colliding1_state)

func _on_receiver_collision_entered(state_manager, receiver):
	if receiver.is_in_group(receiver_group):
		if !colliding_sm.has(state_manager):
			colliding_sm.append(state_manager)
			
		receiver_object = receiver
		if colliding_sm.size() == 1:
			set_state(active_colliding1_state)
		elif colliding_sm.size() == 2:
			set_state(active_colliding2_state)

func _on_receiver_collision_exited(state_manager, receiver):
	if receiver.is_in_group(receiver_group):
		colliding_sm.erase(state_manager)
		
		if colliding_sm.size() == 1:
			set_state(active_colliding1_state)
		elif colliding_sm.size() == 0:
			receiver_object = null
			set_state(idle_state)

func _physics_process(delta):
	if colliding_sm.size() > 0:
		global_transform = colliding_sm[0].global_transform
