extends Event

@onready var marker_2 = $"../../LookAroundChecker/Marker2"
@onready var butterfly_particles_2 = $"../../LookAroundChecker/Marker2/ButterflyParticles2"


func _on_event_started() -> void:
	await get_tree().create_timer(1).timeout
	clear_event_dialogue()
	marker_2.screen_entered.connect(_on_marker_2_screen_entered)

func _on_marker_2_screen_entered():
	await get_tree().create_timer(1).timeout
	butterfly_particles_2.emitting = true
	close_event()
