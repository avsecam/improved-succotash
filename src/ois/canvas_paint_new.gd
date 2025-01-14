extends XRToolsPickable

signal canvas_paint_complete
@onready var progress_view = $"Progress View"
@onready var canvas_paint_receiver = $CanvasPaintReceiver
var PAINT_MESH_REF = preload("res://src/assets/B3/paint_mesh_ref.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	PAINT_MESH_REF.albedo_color.a = 0
	canvas_paint_receiver.set_monitoring(false)
	
	if Events.finished_events.has("ActionInteractPaintedCanvas_Done"):
		queue_free()

func _on_canvas_paint_receiver_action_ended(requirement, total_progress):
	pass


func _on_picked_up(pickable):
	progress_view.visible = false


func _on_easel_snap_zone_has_picked_up(what):
	canvas_paint_receiver.set_monitoring(true)

func _on_associated_event_finished():
	print("PAINTED CANVAS: THIS EVENT IS CALLED FOR SOME REASON")
	#queue_free()


func _on_feedback_percentage_100():
	self.enabled = true
	canvas_paint_complete.emit()
