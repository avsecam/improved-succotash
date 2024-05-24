extends StateBehaviorSettings


func set_behavior_node(behavior : StateBehavior):
	super(behavior)
	$MarginContainer/Main/RaycastLength/SpinBox.value = behavior_node.raycast_length
	$MarginContainer/Main/LaserThickness/SpinBox.value = behavior_node.laser_thickness

func _on_btn_rate_confirm_pressed():
	#print("Changed Interact Rate: %1.2f --> %1.2f" %[behavior_node.rate, $MarginContainer/Main/Rate/SpinBox.value])
	behavior_node.rate = $MarginContainer/Main/Rate/SpinBox.value


func _on_btn_raycast_length_confirm_pressed():
	behavior_node.raycast_length = $MarginContainer/Main/RaycastLength/SpinBox.value


func _on_btn_laser_thickness_confirm_pressed():
	behavior_node.laser_thickness = $MarginContainer/Main/LaserThickness/SpinBox.value
