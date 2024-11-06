extends Panorama

func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func _ready():
	super()
	if camera:
		self.global_position = camera.global_position
	else:
		self.global_position = Vector3(0, 0, 0)
