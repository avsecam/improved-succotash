extends Feedback

@export var canvas_blank : Node3D
@export var canvas_ahrt: Node3D
@onready var progress_view = $"../Progress View"
@onready var canvas_paint_call = $"../MainMesh/CanvasPaintCall"
var PAINT_MESH_REF = preload("res://src/assets/B3/paint_mesh_ref.tres")

var anim_check : bool

signal percentage_100

func show_feedback(requirement, total_progress):
	pass


func _on_canvas_paint_receiver_action_in_progress(requirement, total_progress):
	var percentage = total_progress/requirement
	print("Paint progress: " + str(percentage*100)+"%")
	progress_view.visible = true
	progress_view.change_progress_value(percentage*100)
	
	print("PAINT PROGRESS ALPHA VALUE: "+str(percentage*255))
	PAINT_MESH_REF.albedo_color.a = (percentage) 
	
	if percentage >= 1:
		if !anim_check:
			canvas_blank.visible = false
			canvas_ahrt.visible = true
			progress_view.progress_complete_anim()
			canvas_paint_call.visible = false
			anim_check = true
			percentage_100.emit()
		
