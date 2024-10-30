extends Node3D

@onready var anim = $AnimationPlayer
@export var closed = true
@export var item:XRToolsPickable
@export var item_collider:CollisionShape3D

func _on_top_lever_area_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED and closed:
		anim.play("Crank_Movement")
		closed = false
		item.enabled = true
		item.sleeping = false
		item_collider.disabled = false

func _on_bottom_lever_area_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED and not closed:
		anim.play_backwards("Crank_Movement")
		closed = true
