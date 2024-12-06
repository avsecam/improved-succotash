extends Event

@onready var dirt := $"../../dirt"
@onready var cursed_particles = $"../../cursed_floor/CursedParticles"

func _on_dirt_action_completed(requirement, total_progress):
	close_event()
	dirt.queue_free()
	cursed_particles.visible = true
