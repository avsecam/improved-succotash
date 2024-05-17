extends Control
class_name StateBehaviorSettings

signal change_values

var behavior_node

func set_behavior_node(behavior : StateBehavior):
	behavior_node = behavior
	change_values.connect(behavior_node.change_values)
	$Label.text = behavior_node.name
