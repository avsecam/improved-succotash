extends XRToolsPickable

signal kalabasa_chopped
@onready var kalabasa_whole = $MainMesh/Kalabasa_Whole
@onready var eighths = $MainMesh/Eighths
@onready var halves = $MainMesh/Halves
@onready var quarters = $MainMesh/Quarters

func _on_kalabasa_receiver_action_completed(requirement, total_progress):
	kalabasa_chopped.emit()

func _on_associated_event_finished() -> void:
	kalabasa_whole.visible = false
	halves.visible = false
	quarters.visible = false
	eighths.visible = true

func _on_kalabasa_add_pot_event_finished():
	queue_free()
