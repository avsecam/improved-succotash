extends GPUParticles3D

func _ready():
	self.emitting = true

func _on_finished():
	self.queue_free()
