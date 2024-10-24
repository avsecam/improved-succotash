extends Control

@onready var event_button_container = $control_panel/scrollbar/event_buttons_container
@onready var add_event_pop_up = $add_event_pop_up
@onready var add_event_text_edit = $add_event_pop_up/add_event_pop_up_container/TextEdit
@onready var event_container = $event_container

@onready var get_initial_audio = $edit_look_at_event/GetInitialAudio
@onready var get_ongoing_audio = $edit_look_at_event/GetOngoingAudio
@onready var edit_look_at_event = $edit_look_at_event

@onready var events = $event_container
var selected_event

var EVENT_TEMPLATE = preload("res://src/ems/authoring/event_template.tscn")
const EVENT_BUTTON = preload("res://src/ems/authoring/event_button.tscn")

func _on_add_event_pressed():
	add_event_pop_up.popup_centered()

func _on_add_event_pop_up_confirmed():
	var button = EVENT_BUTTON.instantiate()
	button.text = add_event_text_edit.text
	button.name = add_event_text_edit.text
	event_button_container.add_child(button)
	
	button.connect("pressed", _on_event_button_pressed.bind(button.name))
	
	var event = EVENT_TEMPLATE.instantiate()
	event.name = add_event_text_edit.text
	event_container.add_child(event)
	
func _on_event_button_pressed(name):
	var button_children = event_button_container.get_children()
	var event_children = event_container.get_children()
	var button
	var event
	for child in button_children:
		if child.name == name:
			button = child
	for child in event_children:
		if child.name == name:
			event = child
			selected_event = child
	selected_event = event
	
	$edit_event.visible = true

func _on_save_event_pressed():
	$SaveEventFile.visible = true

func _on_save_event_file_file_selected(path):
	var scene = PackedScene.new()
	for child in events.get_children():
		child.set_owner(events)
	scene.pack(events)
	var error = ResourceSaver.save(scene, path)
	if error != OK:
		print("An error occurred while saving the scene to disk.")
	else:
		print("Saved object to %s" % path)

func _on_load_event_pressed():
	$LoadEventFile.visible = true

func _on_load_event_file_file_selected(path):
	var events = get_node("event_container")
	events.queue_free()
	var loaded_events


func _on_initial_sound_edit_pressed():
	$edit_event/initial_sound_FD.visible = true


func _on_initial_sound_fd_file_selected(path):
	selected_event.initialize_audio.stream = load(path)
