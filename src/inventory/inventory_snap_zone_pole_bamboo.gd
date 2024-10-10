extends "res://src/inventory/inventory_snap_zone.gd"


# Called when the node enters the scene tree for the first time.

signal item_inserted


func _on_has_dropped():
	super()
	
func _on_has_picked_up(picked_up_object):
	super(picked_up_object)
	item_inserted.emit()
