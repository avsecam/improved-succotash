extends RayCast3D

@onready var left_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand")
@onready var right_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand")
@onready var function_pointer_right = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/FunctionPointer")
@onready var function_pointer_left = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand/FunctionPointer")
@onready var pistol_sound = $"../pistol_sound"
signal shot
@onready var gunshot_particles = $"../GunshotParticles"
@onready var gunshot_light = $"../GunshotLight/AnimationPlayer"


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
	if left_hand:
		print("Left Hand node found, connecting signal...")
		left_hand.button_pressed.connect(_on_left_hand_button_pressed)
		print("Left Hand pressed signal connected")
		left_hand.button_released.connect(_on_left_hand_button_released)
		print("Left Hand released signal connected")
	else:
		print("Left Hand node not found!")

func _on_right_hand_button_pressed(name):
	if holding and name == "trigger_click":
		shoot = true
		gunshot_particles.emitting = true
		gunshot_light.play("pointlight_fade")
		AudioHandler.play_sfx("C_Pistol_Gunshot", pistol_sound)
		await get_tree().create_timer(0.05).timeout
		gunshot_particles.emitting = false
	
func _on_left_hand_button_pressed(name):
	if holding and name == "trigger_click":
		shoot = true
		gunshot_particles.emitting = true
		gunshot_light.play("pointlight_fade")
		AudioHandler.play_sfx("C_Pistol_Gunshot", pistol_sound)
		await get_tree().create_timer(0.05).timeout
		gunshot_particles.emitting = false

func _on_right_hand_button_released(name):
	print("Button released: ", name)
	shoot = false

func _on_left_hand_button_released(name):
	print("Button released: ", name)
	shoot = false

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider != null:
			if collider.name == "Crystal_Collider" and shoot:
				var crystal = collider.get_parent().get_node("MainMesh/Dark_Crystal")
				crystal.anim.play("smash")
				AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
				collider.get_parent().get_node("MagicalDistortion/GPUParticles3D").emitting = false
				await crystal.anim.animation_finished
				crystal.shot.emit()
				crystal.get_parent().get_parent().queue_free()


func _on_pistol_picked_up(pickable):
	function_pointer_right.visible = false
	function_pointer_left.visible = false
	holding = true
	print("holding gun")

func _on_pistol_released(pickable, by):
	function_pointer_right.visible = true
	function_pointer_left.visible = true
	holding = false
	print("not holding gun")
