extends Camera3D

const ROTATION_SPEED = 0.04

func _physics_process(_delta):
	if Input.is_action_pressed("ui_left"):
		self.rotate_y(ROTATION_SPEED)
	if Input.is_action_pressed("ui_right"):
		self.rotate_y(-ROTATION_SPEED)
		
