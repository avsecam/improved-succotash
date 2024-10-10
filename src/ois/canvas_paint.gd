extends WipeAction

@onready var anim := $AnimationPlayer
@onready var canvas_hitbox := $InteractArea/CollisionShape3D
@onready var canvas_blank := $MainMesh/Canvas_Blank
@onready var canvas_ahrt := $MainMesh/Canvas_Ahrt

signal canvas_disappear_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_hitbox.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func canvas_disappear():
	anim.play("FlyUpAnimation")
	canvas_ahrt.visible = true
	canvas_blank.visible = false
	await anim.animation_finished
	self.queue_free()
	canvas_disappear_signal.emit()
	

func _on_interact_area_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		canvas_disappear()
	
