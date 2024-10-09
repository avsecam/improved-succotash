extends Event

func _on_canvas_paint_canvas_disappear_signal():
	print("99999999999999999 SIGNAL EMITTED")
	close_event()
