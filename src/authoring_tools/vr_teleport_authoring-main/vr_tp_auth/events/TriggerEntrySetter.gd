class_name TriggerEntrySetter
extends TriggerEntry

var teleporter: Teleporter

var connected: bool = false

func _ready():
	if not teleporter:
		push_error("Teleporter not set.")
		return
	
	($ConnectButton as CheckBox).toggled.connect(_on_ConnectButton_toggled)
	Events.trigger_toggle_connection_requested.connect(_on_trigger_toggle_connection_requested)

func _process(_delta):
	if connected:
		($ConnectButton as CheckBox).set_pressed_no_signal(true)
	else:
		($ConnectButton as CheckBox).set_pressed_no_signal(false)

func set_teleporter(val: Teleporter):
	teleporter = val

func set_connected(val: bool):
	connected = val

func set_state(val: bool):
	$StateButton.text = "TRUE" if val else "FALSE"

func _on_ConnectButton_toggled(_t):
	Events.trigger_toggle_connection_requested.emit(trigger_name, teleporter)

func _on_trigger_toggle_connection_requested(_trigger_name: String, _teleporter: Teleporter):
	if not _trigger_name == trigger_name:
		return
	_teleporter.toggle_lock(_trigger_name)
	connected = not connected
