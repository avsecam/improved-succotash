extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickable_object_body_entered(body):
	for child in get_children():
		if child.has_method("move_to_face"):
			child.move_to_face()
