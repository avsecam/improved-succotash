class_name Teleporter
extends StaticBody3D

@export var enabled: bool = true

# File path of the scene to teleport to
@export var to: String

@export var special_room : bool = false

@onready var mesh: MeshInstance3D = $CollisionShape3D/MeshInstance3D

func _ready():
	self.mesh.mesh.resource_local_to_scene = true
	self.mesh.mesh.material = StandardMaterial3D.new()
	if not to or to.length() <= 0:
		push_warning("Teleporter has no destination to teleport to.")

func _process(_delta):
	if not enabled:
		if special_room:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_SLATE_GRAY)
		else:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_KHAKI)
		
		


func enable_teleporter():
	if !enabled:
		enabled = true
		if special_room:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_SLATE_GRAY)
		else:
			self.mesh.mesh.material.albedo_color = Color(Color.LEMON_CHIFFON)

func set_color(color: Color):
	(self.mesh.mesh.material as StandardMaterial3D).albedo_color = color
