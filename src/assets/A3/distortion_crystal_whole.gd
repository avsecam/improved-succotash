extends Node3D

@onready var anim := $AnimationPlayer
@onready var particles := $GPUParticles3D
@onready var mesh := $Cube
signal shot

func _ready():
	mesh.visible = true

