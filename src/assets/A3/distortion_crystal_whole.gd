extends Node3D

@onready var anim := $AnimationPlayer
@onready var particles := $GPUParticles3D
@onready var mesh := $Cube


func _ready():
	mesh.visible = true

