class_name Teleporter
extends StaticBody3D

# File path of the scene to teleport to
@export var to: String

@onready var mesh: MeshInstance3D = $CollisionShape3D/MeshInstance3D

func _ready():
	self.mesh.mesh.resource_local_to_scene = true
	if not to or to.length() <= 0:
		push_warning("Teleporter has no destination to teleport to.")

func set_color(color: Color):
	(self.mesh.mesh.material as StandardMaterial3D).albedo_color = color
