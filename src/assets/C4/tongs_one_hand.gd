extends XRToolsPickable
@onready var grab_point_hand_left = $GrabPointHandLeft
@onready var grab_point_hand_right = $GrabPointHandRight
@onready var kk_tongs = $MainMesh/kk_tongs
@onready var hands := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D")

var tongs_picked : bool

func _on_left_hand_button_pressed(name):
	if name == "trigger_click" and tongs_picked:
		kk_tongs.set("blend_shapes/Open",0)
		print("TONG PRESS L")
		
func _on_right_hand_button_pressed(name):
	if name == "trigger_click" and tongs_picked:
		kk_tongs.set("blend_shapes/Open",0)
		print("TONG PRESS R")
		
func _on_left_hand_button_released(name):
	if name == "trigger_click" and tongs_picked:
		kk_tongs.set("blend_shapes/Open",0.5)
		print("TONG r L")
		
func _on_right_hand_button_released(name):
	if name == "trigger_click" and tongs_picked:
		kk_tongs.set("blend_shapes/Open",0.5)
		print("TONG r R")

func _ready():
	super()
	kk_tongs.set("blend_shapes/Open",0.5)
	
	print("REAL:" + str(get_tree()))
	print("REAL2:" + str(get_tree().get_root()))
	hands.get_node("LeftHand").button_pressed.connect(_on_left_hand_button_pressed)
	hands.get_node("RightHand").button_pressed.connect(_on_right_hand_button_pressed)
	hands.get_node("LeftHand").button_released.connect(_on_left_hand_button_released)
	hands.get_node("RightHand").button_released.connect(_on_right_hand_button_released)

func _physics_process(delta):
	if !tongs_picked:
		kk_tongs.set("blend_shapes/Open",0.5)
	
func _on_picked_up(pickable):
	tongs_picked = true

func _on_dropped(pickable):
	tongs_picked = false
