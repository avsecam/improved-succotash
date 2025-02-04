extends WipeAction
@onready var main_mesh = $MainMesh
@onready var progress_view = $"Progress View"

signal outside_oil_rag_emit

func _associated_event_done() -> void:
	main_mesh.visible = false
	progress_view.progress_complete_anim()
	
func _process(delta):
	super(delta)
	print("====== OBJECT NAME: "+interacting_object.name)
	if (interacting_object.name == "Rag"):
		print(interacting_object.am_i_oiled())


func _on_oiled_rag_receiver_oiled_rag_interaction():
	outside_oil_rag_emit.emit()
