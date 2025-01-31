extends Event

@onready var marker_3 = $"../../LookAroundChecker/Marker3"
@onready var butterfly_particles_3 = $"../../LookAroundChecker/Marker3/ButterflyParticles3"

func _on_event_started() -> void:
	await get_tree().create_timer(1).timeout
	clear_event_dialogue()
	marker_3.screen_entered.connect(_on_marker_3_screen_entered)

func _on_marker_3_screen_entered():
	await get_tree().create_timer(1).timeout
	butterfly_particles_3.emitting = true
	close_event()
