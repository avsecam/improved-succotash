extends XRToolsPickable

signal garlic_chopped
@onready var garlic_smaller_pieces_2 = $MainMesh/Garlic_SmallerPieces2
@onready var garlic_minced_2 = $MainMesh/Garlic_Minced2

func _on_garlic_receiver_action_completed(requirement, total_progress):
	garlic_chopped.emit()

func _on_associated_event_finished() -> void:
	garlic_smaller_pieces_2.visible = false
	garlic_minced_2.visible = true

func _on_atchara_event_finished():
	queue_free()
