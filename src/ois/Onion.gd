extends XRToolsPickable

signal onion_chopped
# Called when the node enters the scene tree for the first time
@onready var white_onion_peeled_1 = $MainMesh/WhiteOnion_Peeled1
@onready var eighths = $MainMesh/Eighths
@onready var halves = $MainMesh/Halves
@onready var quarters = $MainMesh/Quarters

func _on_onion_receiver_action_completed(requirement, total_progress):
	onion_chopped.emit()

func _on_associated_event_finished() -> void:
	white_onion_peeled_1.visible = false
	halves.visible = false
	quarters.visible = false
	eighths.visible = true
	
func _on_atchara_event_finished():
	queue_free()
