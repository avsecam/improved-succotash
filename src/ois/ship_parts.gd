extends StaticBody3D

@onready var sail_component = $MainMesh/SailComponent
@onready var sail_snap_zone = $SailSnapZone
@onready var progress_view = $"Progress View"
@onready var wheel_snap_zone = $WheelSnapZone

signal ship_parts_assembled
var ship_sail : bool
var ship_wheel : bool
var temp_obj_ref : Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sail_snap_zone_has_picked_up(what):
	sail_component.visible = true
	sail_snap_zone.visible = false
	ship_sail = true
	what.visible = false
	temp_obj_ref = what
	
	if !ship_wheel:
		progress_view.visible = true
		progress_view.change_progress_value(50)
	else:
		ship_parts_complete()
	
func _on_wheel_snap_zone_has_picked_up(what):
	ship_wheel = true
	if !ship_sail:
		progress_view.visible = true
		progress_view.change_progress_value(50)
	else:
		ship_parts_complete()
	
func _on_wheel_snap_zone_has_dropped():
	ship_wheel = false
	if !ship_sail:
		progress_view.change_progress_value(0)

func _on_sail_snap_zone_has_dropped():
	sail_component.visible = false
	sail_snap_zone.visible = true
	temp_obj_ref.visible = true
	ship_sail = false
	if !ship_wheel:
		progress_view.change_progress_value(0)

func ship_parts_complete():
	progress_view.visible = true
	progress_view.change_progress_value(100)
	progress_view.progress_complete_anim()
	sail_snap_zone.enabled = false
	wheel_snap_zone.enabled = false
	ship_parts_assembled.emit()
	



