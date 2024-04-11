extends RigidBody3D


var _material := StandardMaterial3D.new()
@export var switch = false
signal toggled(switch)

func _ready():
	_material.albedo_color = Color("FF0000")
	$MeshInstance3D.material_override = _material

func pointer_event(event : XRToolsPointerEvent) -> void:
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		_toggle()

func _toggle():
	if switch:
		switch = false
		_material.albedo_color = Color("FF0000")
	else:
		switch = true
		_material.albedo_color = Color("#008000")
	toggled.emit(switch)
