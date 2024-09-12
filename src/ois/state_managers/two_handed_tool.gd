extends StateManager
class_name SMTwoHandedTool

@onready var idle_state = $IdleState
@onready var active1_state = $Active1State
@onready var active2_state = $Active2State
@onready var trigger1_state = $Trigger1State
@onready var trigger2_state = $Trigger2State

@onready var actor_object = get_parent()

var active_controllers = []

var a = func(x): if (x == "trigger_click"): _on_trigger_pressed()
var b = func(x): if (x == "trigger_click"): _on_trigger_released()

#TODO pickable signals seems to register twice

func _ready():
	super()
	actor_object.grabbed.connect(_on_actor_object_grabbed)
	actor_object.released.connect(_on_actor_object_released)

func _on_actor_object_released(pickable, by):
	if by is XRToolsFunctionPickup:
		var controller : XRController3D = by.get_controller()
		controller.button_pressed.disconnect(a)
		controller.button_released.disconnect(b)
		active_controllers.erase(controller)
		
		var controller_sm = controller.get_node_or_null("StateManager")
		if controller_sm != null:
			controller_sm._on_object_released()

		#match current_state:
			#active1_state:
				#if active_controllers.size() == 0:
					#set_state(idle_state)
			#active2_state:
				#if active_controllers.size() == 1:
					#set_state(active1_state)
		
		if active_controllers.size() == 0:
			set_state(idle_state)
		elif active_controllers.size() == 1:
			if current_state == trigger1_state || current_state == trigger2_state:
				set_state(trigger1_state)
			else:
				set_state(active1_state)


func _on_actor_object_grabbed(pickable, by):
	if by is XRToolsFunctionPickup:
		var controller : XRController3D = by.get_controller()
		controller.button_pressed.connect(a)
		controller.button_released.connect(b)
		if !active_controllers.has(controller):
			active_controllers.append(controller)
		
		var controller_sm = controller.get_node_or_null("StateManager")
		if controller_sm != null:
			controller_sm._on_object_grabbed()
		
		match current_state:
			idle_state:
				set_state(active1_state)
			active1_state:
				if active_controllers.size() == 2:
					set_state(active2_state)

func _on_trigger_pressed():
	if (receiver_object != null):
		match current_state:
			active1_state:
				set_state(trigger1_state)
			active2_state:
				set_state(trigger1_state)
			trigger1_state:
				set_state(trigger2_state)

func _on_trigger_released():
	match current_state:
		trigger1_state:
			if active_controllers.size() == 2:
				set_state(active2_state)
			elif active_controllers.size() == 1:
				set_state(active1_state)
		trigger2_state:
			set_state(trigger1_state)

func _on_receiver_collision_entered(receiver):
	if receiver.is_in_group(receiver_group):
		receiver_object = receiver
		set_state(current_state)
	else:
		for child in receiver.get_children():
			if child.is_in_group(receiver_group):
				receiver_object = child
				set_state(current_state)
				break

func _on_receiver_collision_exited(receiver):
	if (current_state == active1_state || current_state == active2_state):
		receiver_object = null
		set_state(current_state)
