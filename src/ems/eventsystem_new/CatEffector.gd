extends Node3D

@onready var appear_effect = $"../AppearEffect"
@onready var blessed_particles = $"../BlessedParticles"

# Called when the node enters the scene tree for the first time.
func _ready():
	blessed_particles.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cat_icon_appear():
	blessed_particles.visible = true
	appear_effect.play()
	await get_tree().create_timer(0.5).timeout
	blessed_particles.emitting = true


func _on_cube_cat_calico_picked_up(pickable):
	blessed_particles.emitting = false
