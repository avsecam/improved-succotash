extends StateManager

@export var controller : XRController3D

@onready var idle_state = $IdleState
@onready var active_state = $ActiveState
@onready var trigger_state = $TriggerState

@onready var actor_object = get_parent()

func _ready():
	controller.button_pressed.connect(func(x): if (x == "trigger_click"): _on_trigger_pressed())
	controller.button_released.connect(func(x): if (x == "trigger_click"): _on_trigger_released())

# triggered by object state managers
func _on_object_released():
	set_state(active_state)

# triggered by object state managers
func _on_object_grabbed():
	set_state(idle_state)
	
func _on_trigger_pressed():
	if (receiver_object != null):
		set_state(trigger_state)

func _on_trigger_released():
	if (current_state == trigger_state):
		receiver_object = null
		set_state(active_state)

func _on_receiver_collision_entered(receiver):
	if receiver.is_in_group(receiver_group):
		receiver_object = receiver
		set_state(active_state)

func _on_receiver_collision_exited(receiver):
	if (current_state == active_state):
		receiver_object = null
		set_state(active_state)