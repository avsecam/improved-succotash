extends ReceiverObj

func initialize_action_vars():
	total_progress += rate

func _process(_delta):
	print(total_progress)
	super(_delta)
