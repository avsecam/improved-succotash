extends Node3D


@export var follow_object : Node3D
@export var pointer : RayCast3D

@onready var background := $MeshInstance3D
@onready var anim := $UserInputIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	close_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Events.current_mode == "VR":
		global_transform = follow_object.global_transform
		
		if pointer.is_colliding():
			var object = pointer.get_collider()
			pointer_collision_response(object)
		else:
			close_ui()


func show_action(action_name : String) -> void:
	background.visible = true
	anim.visible = true
	anim.play(action_name)


func close_ui() -> void:
	background.visible = false
	anim.visible = false
	anim.stop()


func pointer_collision_response(obj) -> void:
	if obj is Teleporter:
		show_action("trigger_click")
	elif obj is XRToolsPickable:
		show_action("middle_click")
	elif obj is WipeAction:
		show_action("wave")
	#elif obj is TwistAction:
		#show_action("rotate_left")
	else:
		close_ui()
