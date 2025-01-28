extends RayCast3D

@onready var left_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand")
@onready var right_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand")
@onready var function_pointer_right = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/FunctionPointer")
@onready var function_pointer_left = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand/FunctionPointer")
var holding = false

func _on_katana_picked_up(pickable):
	holding = true
	print("holding katana")
	function_pointer_right.visible = false
	function_pointer_left.visible = false

func _on_katana_released(pickable, by):
	holding = false
	print("not holding gun")
	function_pointer_right.visible = true
	function_pointer_left.visible = true
	
func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider != null:
			if collider.name == "Crystal_Collider" and holding:
				var crystal = collider.get_parent().get_node("MainMesh/Dark_Crystal")
				crystal.anim.play("smash")
				AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
				collider.get_parent().get_node("MagicalDistortion/GPUParticles3D").emitting = false
				await crystal.anim.animation_finished
				crystal.slash.emit()
				crystal.get_parent().get_parent().queue_free()
	if holding:
		function_pointer_right.visible = false
		function_pointer_left.visible = false
	else:
		function_pointer_right.visible = true
		function_pointer_left.visible = true
