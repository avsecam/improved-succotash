extends MeshInstance3D

var FADE_OUT_MAT = preload("res://src/teleportation/fade_OUT_mat.tres")

func _ready():
	FADE_OUT_MAT.albedo_color.a = 0

func _fade_in():
	var rate = 0.75
	FADE_OUT_MAT.albedo_color.a = rate * get_physics_process_delta_time()

func _fade_out():
	var rate = 0.75
	FADE_OUT_MAT.albedo_color.a = 1 - (rate * get_physics_process_delta_time())
