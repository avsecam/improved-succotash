class_name TeleporterAuth
extends StaticBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $CollisionShape3D/MeshInstance3D

# name of key in EventFlags
var locks: Array[String] = []

# If Teleporter is locked
var locked: bool

func _ready():
	mesh_instance.mesh.resource_local_to_scene = true
	mesh_instance.mesh.material = StandardMaterial3D.new()

func _process(_delta):
	mesh_instance.mesh.material.albedo_color = Color("white")
	
	if StateAuth.active_authoring == StateAuth.ActiveAuthoring.Demo:
		self.locked = false
		# If NOT all locks are set to true, disable the Teleporter
		for lock in locks:
			if EventFlags.exists(lock):
				if not EventFlags.value(lock):
					self.locked = true
					mesh_instance.mesh.material.albedo_color = Color(Color.DARK_SLATE_GRAY)
				else:
					continue
		# Ignore locks that don't exist in EventFlags
			else:
				push_warning("Lock ", lock, " does not exist in EventFlags.")
				continue

func set_hovered(value: bool):
	if locked:
		return
	if value:
		mesh_instance.mesh.material.albedo_color = Color("ff77ff")
	else:
		mesh_instance.mesh.material.albedo_color = Color("white")

func toggle_lock(lock_name: String):
	if not locks.has(lock_name):
		locks.append(lock_name)
		print_debug("Lock ", lock_name, " added to teleporter to ", self.teleport_location.name, ".")
	else:
		locks.erase(lock_name)
		print_debug("Lock ", lock_name, " removed from teleporter to ", self.teleport_location.name, ".")
