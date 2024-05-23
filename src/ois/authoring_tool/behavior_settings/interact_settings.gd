extends StateBehaviorSettings

func set_behavior_node(behavior : StateBehavior):
	super(behavior)
	$MarginContainer/Main/Rate/SpinBox.value = behavior_node.rate

func _on_btn_rate_confirm_pressed():
	#print("Changed Interact Rate: %1.2f --> %1.2f" %[behavior_node.rate, $MarginContainer/Main/Rate/SpinBox.value])
	behavior_node.rate = $MarginContainer/Main/Rate/SpinBox.value
