extends Panorama

@onready var shelf = get_node("/root/Demo/Shelf")
@onready var teleport_bar_reference = get_tree().get_root().get_node("/root/Demo/XRPlayer/XROrigin3D/RightHand/TeleportTrigger/MeshInstance3D")

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func _ready():
	super()
	shelf.visible = false
	teleport_bar_reference.visible = false
	if camera:
		self.global_position = camera.global_position
	else:
		self.global_position = Vector3(-2.5, 0, 0)
