extends Node3D


# Called when the node enters the scene tree for the first time.

func _on_combination_lock_interface_lock_solved():
	self.get_parent().visible = true
	self.get_parent().enabled = true
	
