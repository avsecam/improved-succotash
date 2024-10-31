extends XRToolsPickable


signal papaya_grated
@onready var papaya_peeled = $MainMesh/Papaya_Peeled
@onready var papaya_grated_a = $MainMesh/Papaya_Grated


func _on_feedback_papaya_grated_workaround():
	papaya_grated.emit()
	
func _on_associated_event_finished() -> void:
	papaya_peeled.visible = false
	papaya_grated_a.visible = true
	
func _on_atchara_event_finished():
	queue_free()
