extends Control

@onready var event_button_container = $control_panel/scrollbar/event_buttons_container
@onready var add_event_pop_up = $add_event_pop_up
@onready var add_event_text_edit = $add_event_pop_up/add_event_pop_up_container/TextEdit
@onready var event_container = $event_container
@onready var event_prerequisite_container = $event_editing_pop_up/VBoxContainer/ScrollContainer/event_prerequisite_container
@onready var event_editing_pop_up = $event_editing_pop_up
var current_event

const EVENT_TEMPLATE = preload("res://src/ems/authoring/event_template.tscn")
const EVENT_BUTTON = preload("res://src/ems/authoring/event_button.tscn")
const EVENT_PREREQ_CHECK_BOX = preload("res://src/ems/authoring/event_prereq_check_box.tscn")

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
	
	var event_prereq = EVENT_PREREQ_CHECK_BOX.instantiate()
	event_prereq.name = add_event_text_edit.text
	event_prereq.text = add_event_text_edit.text
	event_prerequisite_container.add_child(event_prereq)
	
func _on_event_button_pressed(name):
	var button_children = event_button_container.get_children()
	var event_children = event_container.get_children()
	var event_prereq_children = event_prerequisite_container.get_children()
	
	var button
	var event
	var event_prereq
	
	for child in button_children:
		if child.name == name:
			button = child
			break
	for child in event_children:
		if child.name == name:
			event = child
			current_event = child
			break
	for child in event_prereq_children:
		if child.name == name:
			event_prereq = child
			break
	
	load_event_prerequisite()
	load_object_state()
	event_editing_pop_up.popup_centered()

@onready var event_initialized = $event_editing_pop_up/VBoxContainer/event_initialized
@onready var event_ongoing = $event_editing_pop_up/VBoxContainer/event_ongoing
@onready var event_finished = $event_editing_pop_up/VBoxContainer/event_finished
@onready var event_state_menu = $event_editing_pop_up/VBoxContainer/event_state_menu

func _on_event_editing_pop_up_confirmed():
	save_event_prerequisites()
	save_event_state()
	reset_event_editing_state()

func save_event_prerequisites():
	var event_prereq_children = event_prerequisite_container.get_children()
	for event in event_prereq_children:
		if event.button_pressed == true:
			current_event.conditions.append(event)
		if event.button_pressed == false and current_event.conditions.has(event):
			current_event.conditions.erase(event)

func load_event_prerequisite():
	var event_prereq_children = event_prerequisite_container.get_children()
	for event in current_event.conditions:
		if current_event.conditions.has(event):
			event.button_pressed = true

func save_event_state():
	if event_state_menu.selected == 0:
		current_event.set_state("initialized")
	if event_state_menu.selected == 1:
		current_event.set_state("ongoing")
	if event_state_menu.selected == 2:
		current_event.set_state("finished")

func load_object_state():
	if current_event.state == "initialized":
		event_state_menu.selected = 0
	if current_event.state == "ongoing":
		event_state_menu.selected = 1
	if current_event.state == "finished":
		event_state_menu.selected = 2

func reset_event_editing_state():
	event_state_menu.selected = -1
	
	var event_prereq_children = event_prerequisite_container.get_children()
	for event in event_prereq_children:
		event.button_pressed = false
