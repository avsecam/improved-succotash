extends Node3D

var frame1_name : String
var frame2_name : String
var frame3_name : String
var frame4_name : String
var frame5_name : String

var frame1_correct : bool
var frame2_correct : bool
var frame3_correct : bool
var frame4_correct : bool
var frame5_correct : bool
var anim_check_bool : bool

@onready var frame_1 = $Frame1
@onready var frame_2 = $Frame2
@onready var frame_3 = $Frame3
@onready var frame_4 = $Frame4
@onready var frame_5 = $Frame5
@onready var progress_view = $"Progress View"

signal parchment_arrangement_complete

func _process(delta):
	if frame1_correct and frame2_correct and frame3_correct and frame4_correct and frame5_correct:
		frame_1.enabled = false
		frame_2.enabled = false
		frame_3.enabled = false
		frame_4.enabled = false
		frame_5.enabled = false
		if !anim_check_bool:
			anim_check_bool = true
			progress_view.visible = true
			progress_view.progress_complete_checkmark_only_anim()
			parchment_arrangement_complete.emit()
		
func _on_frame_1_has_picked_up(what):
	# 1753 Old Parchment (A)
	if what.name == "parchment_a":
		frame1_correct = true
	else:
		frame1_correct = false


func _on_frame_2_has_picked_up(what):
	# 1951 Cat Picture (D)
	if what.name == "parchment_d":
		frame2_correct = true
	else:
		frame2_correct = false


func _on_frame_3_has_picked_up(what):
	# 1996 Church Front (E)
	if what.name == "parchment_e":
		frame3_correct = true
	else:
		frame3_correct = false


func _on_frame_4_has_picked_up(what):
	# 2017 Brochure (C)
	if what.name == "parchment_c":
		frame4_correct = true
	else:
		frame4_correct = false


func _on_frame_5_has_picked_up(what):
	# 2024 Kid Drawing (B)
	if what.name == "parchment_b":
		frame5_correct = true
	else:
		frame5_correct = false


func _on_frame_1_has_dropped():
	frame1_correct = false


func _on_frame_2_has_dropped():
	frame2_correct = false


func _on_frame_3_has_dropped():
	frame3_correct = false


func _on_frame_4_has_dropped():
	frame4_correct = false


func _on_frame_5_has_dropped():
	frame5_correct = false
