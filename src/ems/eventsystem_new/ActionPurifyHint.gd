extends Event

@onready var curse := $"../../cursed_floor"
@onready var blessed_particles = $"../../BlessedParticles"
@onready var appear_effect = $"../../AppearEffect"


func _on_cursed_floor_action_completed(requirement, total_progress):
	
	curse.queue_free()
	
	


func _on_cursed_floor_purify_hint_event_end():
	appear_effect.play()
	blessed_particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	blessed_particles.emitting = false
	close_event()
