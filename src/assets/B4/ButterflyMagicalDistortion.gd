extends Node3D

@onready var particles := $GPUParticles3D
# Called when the node enters the scene tree for the first time.
func _ready():
	particles.emitting = true
	if Events.finished_events.has("QuestLookAtTheButterflies_Done"):
		queue_free()

func _process(delta):
	pass
