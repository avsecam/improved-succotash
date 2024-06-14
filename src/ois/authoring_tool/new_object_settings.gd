extends ConfirmationDialog

@onready var cb_actor = $NewObjectSettings/CBActor
@onready var cb_receiver = $NewObjectSettings/CBReceiver
@onready var cb_inventory = $NewObjectSettings/CBInventory
@onready var actor_type_selector = $NewObjectSettings/ActorTypeSelector

# Configure checkbox settings given implementation restrictions and considerations

# Current restrictions include:
# Cannot easily have object be receiver and actor at once
# Cannot be a receiver and inventory object

# Other considerations include:
# To simplify implementation and given escape room context,
# don't allow an inventory item that is not an actor object

func _ready():
	actor_type_selector.add_item("One-Handed Tool")
	actor_type_selector.add_item("Two-Handed Tool")

func _on_cb_actor_toggled(toggled_on):
	if toggled_on:
		actor_type_selector.disabled = false
		actor_type_selector.selected = 0
		
		cb_receiver.disabled = true
		cb_receiver.button_pressed = false
		cb_inventory.disabled = false
		
		get_ok_button().disabled = false
	else:
		actor_type_selector.disabled = true
		actor_type_selector.selected = -1
		
		cb_receiver.disabled = false
		cb_inventory.disabled = true
		cb_inventory.button_pressed = false
		
		get_ok_button().disabled = true

func _on_cb_receiver_toggled(toggled_on):
	if toggled_on:
		cb_actor.disabled = true
		cb_actor.button_pressed = false
		cb_inventory.disabled = true
		cb_inventory.button_pressed = false
		
		get_ok_button().disabled = false
	else:
		cb_actor.disabled = false
		cb_inventory.disabled = false
		
		get_ok_button().disabled = true

func reset():
	get_ok_button().disabled = true
	cb_inventory.disabled = true
	actor_type_selector.selected = -1
	# reset checkboxes
	cb_actor.button_pressed = false
	cb_receiver.button_pressed = false
	cb_inventory.button_pressed = false
