@tool
class_name Level
extends Node3D

const AREAS_DIR = "res://src/areas/"

const IDLE_COLOR := Color("white")
const ACTIVE_COLOR := Color("red")

var data: Dictionary

@onready var camera: XRCamera3D = XRHelpers.get_xr_camera(self.get_parent())

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var teleporters_container: Node3D = $Teleporters
@export var teleporters_data: Array # of {position: Vector3, to: String}

@export var base_rotation: float = 0.0
@export var outside: bool = true

func _ready():
	for teleporter in teleporters_container.get_children():
		teleporters_container.remove_child(teleporter)
		teleporter.queue_free()
	
	_set_teleporters()
	
	Events.connect("teleporter_hovered", _on_teleporter_hovered)
	Events.connect("no_teleporter_hovered", _on_no_teleporter_hovered)
	Events.connect("non_vr_teleporter_hovered", _on_teleporter_hovered)
	Events.connect("non_vr_no_teleporter_hovered", _on_no_teleporter_hovered)
	
	Bgm.set_outside(outside)


func _physics_process(delta):
	if Engine.is_editor_hint():
		return

func _set_teleporters():
	for teleporter_data in teleporters_data:
		print("Adding teleporter with data ", teleporter_data)
		
		var teleporter = preload("res://src/teleportation/Teleporter.tscn").instantiate()
		if (teleporter_data as Dictionary).get("to"):
			teleporter.name = teleporter_data.to
			teleporter.to = teleporter_data.to
		else:
			teleporter.name = "TeleportSpot"
		teleporter.position = teleporter_data.position
		
		teleporters_container.add_child(teleporter)
		teleporter.owner = self

# TELEPORTER SIGNALS
func _on_teleporter_hovered(teleporter: Teleporter):
	if teleporter and teleporter.enabled:
		teleporter.set_color(ACTIVE_COLOR)

func _on_no_teleporter_hovered():
	for teleporter in teleporters_container.get_children():
		teleporter.set_color(IDLE_COLOR)
