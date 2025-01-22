extends RayCast3D

@onready var left_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand")
@onready var right_hand = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand")
@onready var pistol_sound = $"../pistol_sound"
signal shot

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
	shoot = true
	if holding and name == "trigger_click":
		AudioHandler.play_sfx("C_Pistol_Gunshot", pistol_sound)

func _on_right_hand_button_released(name):
	print("Button released: ", name)
	shoot = false

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider != null:
			print("Shot hit: ", collider.name)
			if collider.name == "Crystal_Collider" and shoot:
				collider.get_parent().queue_free()


func _on_pistol_picked_up(pickable):
	holding = true
	print("holding gun")

func _on_pistol_released(pickable, by):
	holding = false
	print("not holding gun")
