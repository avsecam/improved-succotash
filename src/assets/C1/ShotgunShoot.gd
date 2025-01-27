extends RayCast3D

@onready var left_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand")
@onready var right_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand")
@onready var function_pointer_right = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/FunctionPointer")
@onready var function_pointer_left = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand/FunctionPointer")
@onready var shotgun_sound = $"../shotgun_sound"

var shoot = false
var holding = false

func _ready():
	if right_hand:
		print("Right Hand node found, connecting signal...")
		right_hand.button_pressed.connect(_on_right_hand_button_pressed)
		print("Right Hand pressed signal connected")
		right_hand.button_released.connect(_on_right_hand_button_released)
		print("Right Hand released signal connected")
	else:
		print("Right Hand node not found!")

func _on_right_hand_button_pressed(name):
	if holding and name == "trigger_click":
		shoot = true
		AudioHandler.play_sfx("C_ShotGunshot", shotgun_sound)

func _on_right_hand_button_released(name):
	print("Button released: ", name)
	shoot = false

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider != null:
			print(collider.name)
			if collider.name == "Crystal_Collider" and shoot:
				var crystal = collider.get_parent().get_node("MainMesh/Dark_Crystal")
				crystal.anim.play("smash")
				AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
				await crystal.anim.animation_finished
				crystal.shot.emit()
				crystal.get_parent().get_parent().queue_free()


func _on_shotgun_picked_up(pickable):
	function_pointer_right.visible = false
	function_pointer_left.visible = false
	holding = true
	print("holding shotgun")

func _on_shotgun_released(pickable, by):
	function_pointer_right.visible = true
	function_pointer_left.visible = true
	holding = false
	print("not holding shotgun")
