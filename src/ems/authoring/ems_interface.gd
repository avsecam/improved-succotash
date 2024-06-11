extends Control

@onready var event_button_container = $control_panel/scrollbar/event_buttons_container
@onready var add_event_pop_up = $add_event_pop_up
@onready var add_event_text_edit = $add_event_pop_up/add_event_pop_up_container/TextEdit
@onready var event_container = $event_container

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
			print("Found Button Child")
	for child in button_children:
		if child.name == name:
			event = child
			print("Found Event Child")
	
