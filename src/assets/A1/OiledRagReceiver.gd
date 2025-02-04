extends WipeAction
# Called every frame. 'delta' is the elapsed time since the previous frame.
signal oiled_rag_interaction

func _process(delta):
	super(delta)
	print("====== OILED RAG LIMAW... umak")
	oiled_rag_interaction.emit()
