extends XRToolsPickable

@onready var function_pointer_right = get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/FunctionPointer")
@onready var function_pointer_left = get_node("/root/Demo/XRPlayer/XROrigin3D/LeftHand/FunctionPointer")
var holding = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_picked_up(pickable):
	function_pointer_right.visible = false
	function_pointer_left.visible = false
	holding = true
	print("holding katana")


func _on_released(pickable, by):
	function_pointer_right.visible = true
	function_pointer_left.visible = true
	holding = false
