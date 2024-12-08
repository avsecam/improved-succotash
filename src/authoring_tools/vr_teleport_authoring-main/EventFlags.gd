extends Node

# { "triggerName": bool }
@export var data: Dictionary

func _ready():
	Events.trigger_add_requested.connect(_on_trigger_add_requested)
	Events.trigger_delete_requested.connect(_on_trigger_delete_requested)
	Events.trigger_toggle_requested.connect(_on_trigger_toggle_requested)
	Events.trigger_set_requested.connect(_on_trigger_set_requested)

func exists(trigger_name: String):
	return data.has(trigger_name)

func value(trigger_name: String):
	return data.get(trigger_name)

func clear():
	data.clear()

func _clean_name(trigger_name: String):
	var ret = trigger_name.to_lower()
	ret.replace(" ", "_")
	return ret

func _on_trigger_add_requested(trigger_name: String):
	var actual_trigger_name = _clean_name(trigger_name)
	if self.exists(actual_trigger_name):
		push_warning("Trigger ", actual_trigger_name, " already exists.")
	data[actual_trigger_name] = false
	Events.trigger_add_confirmed.emit(actual_trigger_name)
	print_debug("Trigger ", actual_trigger_name, " added.")

func _on_trigger_delete_requested(trigger_name: String):
	if not self.exists(trigger_name):
		push_warning("Trigger ", trigger_name, " does not exist.")
	data.erase(trigger_name)
	Events.trigger_delete_confirmed.emit(trigger_name)
	print_debug("Trigger ", trigger_name, " deleted.")

func _on_trigger_toggle_requested(trigger_name: String):
	if not self.exists(trigger_name):
		push_error("Trigger ", trigger_name, " does not exist.")
		return
	data[trigger_name] = not data[trigger_name]
	print_debug("Trigger ", trigger_name, " toggled to ", data[trigger_name], ".")

func _on_trigger_set_requested(trigger_name: String, val: bool):
	if not self.exists(trigger_name):
		push_error("Trigger ", trigger_name, " does not exist.")
		return
	data[trigger_name] = val
	print_debug("Trigger ", trigger_name, " set to ", val, ".")
