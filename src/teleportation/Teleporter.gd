class_name Teleporter
extends StaticBody3D


# File path of a JSON resource
@export var to: String


func _ready():
	if not to or to.length() <= 0:
		push_warning("Teleporter has no destination to teleport to.")
