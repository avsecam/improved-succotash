extends Control

@onready var event_container = $control_panel/event_buttons_container
@onready var add_event_pop_up = $add_event_pop_up
@onready var add_event_text_edit = $add_event_pop_up/Container/TextEdit

func _on_add_event_pressed():
	add_event_pop_up.popup_centered()


func _on_add_event_pop_up_confirmed():
	var button = Button.new()
	button.text = add_event_text_edit.text
	button.name = "event_" + add_event_text_edit.text
	event_container.add_child(button)
