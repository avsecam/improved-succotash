extends Node3D

@onready var raycast: RayCast3D = $RayCast3D
@onready var raycast_mesh: MeshInstance3D = $MeshInstance3D

const RAY_COLOR_DEFAULT: Color = Color("white")
const RAY_COLOR_COLLIDING: Color = Color("red")

@onready var controller := XRHelpers.get_right_controller(self.get_parent())
@onready var camera := XRHelpers.get_xr_camera(self.get_parent())
@onready var origin := XRHelpers.get_xr_origin(self.get_parent())

@onready var button_pressed_last_frame: bool = false


func _physics_process(delta):
	var button_pressed_this_frame := controller.is_button_pressed("trigger_click")

	# Enable teleportation requests and show raycast when holding down trigger button
	if button_pressed_this_frame:
		self.visible = true
	else:
		self.visible = false

	# Check if ray is colliding with a teleporter
	var raycast_is_colliding = raycast.is_colliding()
	var raycast_mesh_material := (raycast_mesh.mesh as CylinderMesh).material as StandardMaterial3D
	if raycast_is_colliding:
		raycast_mesh_material.albedo_color = RAY_COLOR_COLLIDING
	else:
		raycast_mesh_material.albedo_color = RAY_COLOR_DEFAULT

#	# Request teleport when trigger is released while targeting a teleporter
	if controller.get_is_active() \
		and button_pressed_last_frame \
		and not button_pressed_this_frame \
		and raycast_is_colliding:
			# Get object raycast is colliding with
			var teleporter = raycast.get_collider()
			
			if (teleporter is Teleporter):
				Events.emit_signal("player_teleport_requested_trigger", teleporter.to)

	button_pressed_last_frame = button_pressed_this_frame
