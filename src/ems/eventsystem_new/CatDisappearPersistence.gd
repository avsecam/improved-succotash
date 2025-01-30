extends Node3D

@onready var cat = $".."

func on_disappear_cat():
	cat.visible = false
	
