extends Event

@onready var hammer = $"../../Hammer"

func _on_combination_lock_interface_lock_solved():
	hammer.visible = true
	close_event()
