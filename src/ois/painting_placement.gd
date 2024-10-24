extends Node3D

signal painting_placed

var anim_check : bool
@onready var progress_view = $"Progress View"
@onready var canvas_ahrt = $Canvas_Ahrt
@onready var painting_place = $PaintingPlace


func _on_test_area_entered(area):
	if !anim_check and area.name == "CanvasPaintReceiver":
		canvas_ahrt.visible = true
		area.get_parent().queue_free()
		painting_placed.emit()
		progress_view.visible = true
		progress_view.progress_complete_checkmark_only_anim()
		anim_check = true
