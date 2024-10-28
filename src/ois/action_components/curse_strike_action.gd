extends "res://src/ois/action_components/strike_action.gd"


func _on_associated_event_finished():
	queue_free()
