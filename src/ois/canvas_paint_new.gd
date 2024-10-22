extends XRToolsPickable

signal canvas_paint_complete
@onready var progress_view = $"Progress View"
@onready var canvas_paint_receiver = $CanvasPaintReceiver

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	canvas_paint_receiver.set_monitoring(false)

func _on_canvas_paint_receiver_action_ended(requirement, total_progress):
	self.enabled = true
	canvas_paint_complete.emit()


func _on_picked_up(pickable):
	progress_view.visible = false


func _on_easel_snap_zone_has_picked_up(what):
	canvas_paint_receiver.set_monitoring(true)
