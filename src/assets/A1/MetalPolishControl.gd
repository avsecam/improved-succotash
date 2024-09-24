extends Node3D

@export var container_lid : MeshInstance3D
@export var container_lid_inv : MeshInstance3D
@export var control_raycast : Node3D
@export var animation_player : AnimationPlayer

@export var lid_opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if lid_opened:
		open_lid()
		print("lid_opened")
	else:
		close_lid()
		print("lid_closed")
	pass

func open_lid():
	#animation_player.play("open_lid")
	await animation_player.animation_finished
	container_lid.visible = false
	container_lid_inv.visible = false
	control_raycast.raycast_length = 0.2
	print("lid opened")


func close_lid():
	container_lid.visible = true
	container_lid.visible = true
	control_raycast.raycast_length = 0.0
	control_raycast.enable_raycast(false)
	


func _on_receiver_comp_action_completed(requirement, total_progress):
	if !lid_opened:
		print("opening lid")
		open_lid()
