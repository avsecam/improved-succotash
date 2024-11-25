extends XRToolsPickable
@onready var grab_point_hand_left = $GrabPointHandLeft
@onready var grab_point_hand_right = $GrabPointHandRight
@onready var kk_tongs = $MainMesh/kk_tongs
@onready var hands := get_tree().get_root().get_node("Demo/XRPlayer/XROrigin3D")
@onready var tongs_snap_zone = $TongsSnapZone
@onready var tongs_cs3d = $TongsSnapZone/CollisionShape3D

var tongs_picked : bool
var crucible_picked : bool
var picked_hand_L : bool
var picked_hand_R : bool

func _on_left_hand_button_pressed(name):
	if name == "grip_click" and !picked_hand_R:
		picked_hand_L = true
	if !picked_hand_R:
		tongs_snap_zone.rotation_degrees.z = 90
		if name == "trigger_click" and tongs_picked:
			kk_tongs.set("blend_shapes/Open",0)
			#print("TONG PRESS L")
			enable_tongs_snap_zone()
		
func _on_right_hand_button_pressed(name):
	if name == "grip_click" and !picked_hand_L:
		picked_hand_R = true
	if !picked_hand_L:
		tongs_snap_zone.rotation_degrees.z = -90
		if name == "trigger_click" and tongs_picked:
			kk_tongs.set("blend_shapes/Open",0)
			#print("TONG PRESS R")
			enable_tongs_snap_zone()
		
func _on_left_hand_button_released(name):
	if !picked_hand_R:
		if name == "trigger_click" and tongs_picked:
			kk_tongs.set("blend_shapes/Open",0.5)
			#print("TONG r L")
			disable_tongs_snap_zone()
		
func _on_right_hand_button_released(name):
	if !picked_hand_L:
		if name == "trigger_click" and tongs_picked:
			kk_tongs.set("blend_shapes/Open",0.5)
			#print("TONG r R")
			disable_tongs_snap_zone()

func _ready():
	super()
	kk_tongs.set("blend_shapes/Open",0.5)
	disable_tongs_snap_zone()

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
	picked_hand_L = false
	picked_hand_R = false

func enable_tongs_snap_zone():
	print("tongs sz enabled")
	tongs_snap_zone.enabled = true
	tongs_cs3d.disabled = false

func disable_tongs_snap_zone():
	print("tongs sz disabled")
	tongs_snap_zone.drop_object()
	tongs_snap_zone.enabled = false
	tongs_cs3d.disabled = true
	

func _on_tongs_snap_zone_has_picked_up(what):
	crucible_picked = true
	print("cr picked")


func _on_tongs_snap_zone_has_dropped():
	crucible_picked = false
	print("cr dropped")
