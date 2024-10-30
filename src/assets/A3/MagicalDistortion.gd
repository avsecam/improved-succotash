extends Node3D

@onready var particles := $GPUParticles3D
# Called when the node enters the scene tree for the first time.
func _ready():
	if Events.finished_events.has("QuestPurifyTheMuseum_Done"):
		particles.emitting = true
	if Events.finished_events.has("QuestDestroyTheDistortionCrystal_Done"):
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
