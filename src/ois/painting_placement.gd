extends Node3D

signal painting_placed

var anim_check : bool
@onready var progress_view = $"Progress View"
@onready var frame_3 = $Frame3

func _on_frame_3_has_picked_up(what):
	if what.name == "canvas_painting_new":
		if !anim_check:
			painting_placed.emit()
			progress_view.visible = true
			progress_view.progress_complete_checkmark_only_anim()
			anim_check = true
			frame_3.enabled = false
		
