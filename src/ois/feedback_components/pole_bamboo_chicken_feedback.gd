extends Feedback

@onready var chicken_raw_1 = $MainMesh/ChickenRaw1
@onready var chicken_raw_2 = $MainMesh/ChickenRaw2
@onready var cooked = $MainMesh/Cooked

	
func show_feedback(requirement, total_progress):
	pass


func _on_chicken_receiver_action_ended(requirement, total_progress):
	
