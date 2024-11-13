extends XRToolsInteractableSlider


func _do_move_slider(position: float) -> float:
	# Apply slider step-quantization
	if slider_steps:
		position = round(position / slider_steps) * slider_steps

	# Apply slider limits
	position = clamp(position, slider_limit_min, slider_limit_max)

	# Move if necessary
	if position != slider_position:
		transform.origin.x = position

	# Return the updated position
	return position

func _on_slider_released(_interactable: XRToolsInteractableSlider):
	if default_on_release:
		move_slider(default_position)

	
	
