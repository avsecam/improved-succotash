extends AnimationPlayer
var open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			if !open:
				play("Opener")
				open = true
			else:
				play("Closer")
				open = false

func pointer_event(event : XRToolsPointerEvent) -> void:
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		_openClose()

func _openClose():
	if !open:
		play("Opener")
		open = true
	else:
		play("Closer")
		open = false
