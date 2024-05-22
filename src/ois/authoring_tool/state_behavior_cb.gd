extends CheckBox

var state : String = ""
var behavior : String = ""

signal change_value(state, behavior, value)

func set_values(state_name, behavior_name):
	state = state_name
	behavior = behavior_name

func _on_toggled(toggled_on):
	change_value.emit(state, behavior, toggled_on)
