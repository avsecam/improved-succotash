extends Node3D

signal lock_solved()

@export var code : String

@onready var anim := $AnimationPlayer
@onready var button_hitbox := $XRToolsInteractableArea/CollisionShape3D

@onready var wheel1 := $"CombinationLock Wheel"
@onready var wheel2 := $"CombinationLock Wheel2"
@onready var wheel3 := $"CombinationLock Wheel3"
@onready var wheel4 := $"CombinationLock Wheel4"

var lock_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	lock_active(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func lock_active(b: bool):
	button_hitbox.disabled = !b
	wheel1.wheel_hitboxes_active(b)
	wheel2.wheel_hitboxes_active(b)
	wheel3.wheel_hitboxes_active(b)
	wheel4.wheel_hitboxes_active(b)

func check_answer() -> void:
	if !lock_open:
		var answer := str(wheel1.get_number()) + str(wheel2.get_number()) + str(wheel3.get_number()) + str(wheel4.get_number())
		if answer == code:
			lock_open = true
			anim.play("open_lock")
			await anim.animation_finished
			await get_tree().create_timer(0.5).timeout
			emit_signal("lock_solved")
		else:
			anim.play("open_lock_fail")


func _on_xr_tools_interactable_area_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		check_answer()
