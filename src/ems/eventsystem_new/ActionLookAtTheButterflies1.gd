extends Event
@onready var marker_1 = $"../../LookAroundChecker/Marker1"
@onready var butterfly_particles = $"../../LookAroundChecker/Marker1/ButterflyParticles"

func _on_event_started() -> void:
	clear_event_dialogue()
	marker_1.screen_entered.connect(_on_marker_1_screen_entered)

func _on_marker_1_screen_entered():
	await get_tree().create_timer(1).timeout
	butterfly_particles.emitting = true
	close_event()
