extends Node3D

@export_range(0, 9) var number : int

@onready var anim := $AnimationPlayer
@onready var move_up_hitbox := $MoveUp/CollisionShape3D
@onready var move_down_hitbox := $MoveDown/CollisionShape3D

func _ready():
	pass
	#wheel_hitboxes_active(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func wheel_hitboxes_active(b: bool) -> void:
	move_up_hitbox.disabled = !b
	move_down_hitbox.disabled = !b

func get_number() -> int:
	return number


func move_wheel_up() -> void:
	match number:
		0: 
			anim.play("0_to_1")
			number = 1
		1:
			anim.play("1_to_2")
			number = 2
		2:
			anim.play("2_to_3")
			number = 3
		3:
			anim.play("3_to_4")
			number = 4
		4:
			anim.play("4_to_5")
			number = 5
		5:
			anim.play("5_to_6")
			number = 6
		6: 
			anim.play("6_to_7")
			number = 7
		7:
			anim.play("7_to_8")
			number = 8
		8:
			anim.play("8_to_9")
			number = 9
		9:
			anim.play("9_to_0")
			number = 0


func move_wheel_down() -> void:
	match number:
		0: 
			anim.play_backwards("9_to_0")
			number = 9
		1:
			anim.play_backwards("0_to_1")
			number = 0
		2:
			anim.play_backwards("1_to_2")
			number = 1
		3:
			anim.play_backwards("2_to_3")
			number = 2
		4:
			anim.play_backwards("3_to_4")
			number = 3
		5:
			anim.play_backwards("4_to_5")
			number = 4
		6: 
			anim.play_backwards("5_to_6")
			number = 5
		7:
			anim.play_backwards("6_to_7")
			number = 6
		8:
			anim.play_backwards("7_to_8")
			number = 7
		9:
			anim.play_backwards("8_to_9")
			number = 8


func _on_move_up_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		move_wheel_up()


func _on_move_down_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		move_wheel_down()
