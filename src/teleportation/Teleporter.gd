class_name Teleporter
extends StaticBody3D

@export var enabled: bool = true

# File path of the scene to teleport to
@export var to: String

@export var special : bool

@onready var mesh: MeshInstance3D = $CollisionShape3D/MeshInstance3D
@onready var portal_mesh = $CollisionShape3D2/PortalMesh
@onready var main_collision_mesh = $CollisionShape3D
@onready var special_collision_mesh = $SpecialCollisionMesh
@onready var specialeffectssound = $SpecialCollisionMesh/AudioStreamPlayer3D
@onready var portal_anim_player = $SpecialCollisionMesh/PortalMesh/PortalAnimPlayer

func _ready():
	self.mesh.mesh.resource_local_to_scene = true
	self.mesh.mesh.material = StandardMaterial3D.new()
	if special:
		main_collision_mesh.disabled = true
		main_collision_mesh.visible = false
		special_collision_mesh.disabled = false
		special_collision_mesh.visible = true
		if enabled:
			specialeffectssound.play()
		
	else:
		main_collision_mesh.disabled = false
		main_collision_mesh.visible = true
		special_collision_mesh.disabled = true
		special_collision_mesh.visible = false
	if not to or to.length() <= 0:
		push_warning("Teleporter has no destination to teleport to.")

func _process(_delta):
	if not enabled:
		if special:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_KHAKI)
			#special_collision_mesh.visible = false
		else:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_SLATE_GRAY)
		
		
func enable_teleporter():
	if !enabled:
		enabled = true
		if special:
			self.mesh.mesh.material.albedo_color = Color(Color.DARK_SEA_GREEN)
			special_collision_mesh.visible = true
			play_special_closing_portal()
			specialeffectssound.play()
		else:
			self.mesh.mesh.material.albedo_color = Color(Color.WHITE)

func set_color(color: Color):
	(self.mesh.mesh.material as StandardMaterial3D).albedo_color = color

func play_special_closing_portal():
	print("Special Portal Closing")
	portal_anim_player.play("closing")
	self.enabled = false
	
func play_special_opening_portal():
	print("Special Portal Opening")
	portal_anim_player.play("opening")
	self.enabled = true
