class_name ConnectionEntry
extends HBoxContainer

const focused_color := Color(0, 1, 1)
const unfocused_color := Color(1, 1, 1)

@onready var label: Button = $AreaName

@export var focused: bool = false

@export var teleporter: TeleporterAuth
@export var connected_to: TeleportNode:
	set(value):
		label.text = value.area_name
		connected_to = value

func _ready():
	label.pressed.connect(_on_area_name_button_pressed)
	$Delete.pressed.connect(_on_delete_button_pressed)
	$Locks.pressed.connect(_on_locks_button_pressed)
	
	label.text = connected_to.area_name if connected_to else ""

func _process(_delta):
	$Delete.visible = (teleporter != null) or (teleporter and not (teleporter is TeleporterOutsideConnection))
	modulate = focused_color if focused else unfocused_color

func _on_area_name_button_pressed():
	Events.connection_entry_select_requested.emit(self)

func _on_delete_button_pressed():
	Events.connection_entry_delete_requested.emit(self)

func _on_locks_button_pressed():
	if teleporter:
		Events.locks_toggle_requested.emit(teleporter)
	else:
		push_error("ConnectionEntry has no teleporter set.")
