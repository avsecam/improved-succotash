extends ColorRect

const MODAL_COLOR = Color("#0000004f")
const TRIGGER_ENTRY = preload("res://src/events/TriggerEntrySetter.tscn")
const LOCKS_SETTER = preload("res://src/events/LocksSetter.tscn")

@onready var text_edit: TextEdit = $LocksSetter/MarginContainer/VBoxContainer/HBoxContainer/TextEdit
@onready var add_trigger_button: Button = $LocksSetter/MarginContainer/VBoxContainer/HBoxContainer/Button

@onready var trigger_list: VBoxContainer = $LocksSetter/MarginContainer/VBoxContainer/TriggerNames

# Teleporter to set locks for
var teleporter: Teleporter

func _ready():
	if not teleporter:
		push_error("Teleporter not set.")
		queue_free()
		return

	# Add event flags to trigger_list
	for flag in EventFlags.data.keys():
		var entry: TriggerEntrySetter = TRIGGER_ENTRY.instantiate()
		entry.set_teleporter(teleporter)
		entry.set_trigger_name(flag)
		entry.set_state(EventFlags.value(flag))
		entry.set_connected(teleporter.locks.has(flag))
		trigger_list.add_child(entry)

	self.add_trigger_button.pressed.connect(_on_add_trigger_button_pressed)
	Events.trigger_add_confirmed.connect(_on_trigger_add_confirmed)
	Events.trigger_delete_confirmed.connect(_on_trigger_delete_confirmed)
	
	$LocksSetter/MarginContainer/VBoxContainer/Close.pressed.connect(_on_Close_pressed)

func _process(_delta):
	if not text_edit.text:
		add_trigger_button.disabled = true
	else:
		add_trigger_button.disabled = false

func _on_add_trigger_button_pressed():
	var trigger_name = text_edit.text
	
	if EventFlags.exists(trigger_name.to_lower()):
		push_warning("Trigger ", trigger_name, " already exists.")
	else:
		text_edit.text = ""
		Events.trigger_add_requested.emit(trigger_name)

func _on_trigger_add_confirmed(trigger_name: String):
	var entry: TriggerEntry = TRIGGER_ENTRY.instantiate()
	entry.set_trigger_name(trigger_name)
	entry.set_teleporter(teleporter)
	trigger_list.add_child(entry)

func _on_trigger_delete_confirmed(trigger_name: String):
	for child in trigger_list.get_children():
		if (child as TriggerEntry).trigger_name == trigger_name:
			child.queue_free()
			break

func _on_Close_pressed():
	queue_free()
