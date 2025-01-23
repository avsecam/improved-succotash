extends Node3D

@onready var anim := $AnimationPlayer
@onready var particles := $GPUParticles3D
@onready var mesh := $Cube
@export var sword:XRToolsPickable

signal shot

func _ready():
	mesh.visible = true

func _on_crystal_collider_body_exited(body):
	if body == sword:
		print("Katana Slash")
		anim.play.play("smash")
		AudioHandler.play_sfx("A_CrystalShatter", $"../AudioStreamPlayer3D")
		await anim.animation_finished
		get_parent().get_parent().queue_free()
	
