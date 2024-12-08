extends Control

const TRIGGER_ENTRY = preload("res://src/events/TriggerEntry.tscn")

@onready var text_edit: TextEdit = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/TextEdit
@onready var add_trigger_button: Button = $MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/Button

@onready var trigger_list: VBoxContainer = $MarginContainer/MarginContainer/VBoxContainer/TriggerNames

func _ready():
	self.add_trigger_button.pressed.connect(_on_add_trigger_button_pressed)
	Events.trigger_add_confirmed.connect(_on_trigger_add_confirmed)
	Events.trigger_delete_confirmed.connect(_on_trigger_delete_confirmed)
	$MarginContainer/MarginContainer/VBoxContainer/Close.pressed.connect(_on_Close_pressed)
	
	for flag in EventFlags.data.keys():
		var entry = TRIGGER_ENTRY.instantiate()
		entry.set_trigger_name(flag)
		trigger_list.add_child(entry)

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
	trigger_list.add_child(entry)

func _on_trigger_delete_confirmed(trigger_name: String):
	for child in trigger_list.get_children():
		if (child as TriggerEntry).trigger_name == trigger_name:
			child.queue_free()
			break

func _on_Close_pressed():
	queue_free()
