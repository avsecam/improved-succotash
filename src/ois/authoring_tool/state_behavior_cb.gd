extends CheckBox

var state : String = ""
var behavior : String = ""

signal change_value(state, behavior, value)

func _on_toggled(toggled_on):
	print(toggled_on)
	change_value.emit(state, behavior, toggled_on)
