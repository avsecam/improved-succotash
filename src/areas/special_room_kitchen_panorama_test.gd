extends Panorama

@onready var shelf = get_node("/root/Demo/Shelf")

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func _ready():
	super()
	shelf.visible = false
	if camera:
		self.global_position = camera.global_position
	else:
		self.global_position = Vector3(-1.5, 0, 0)
