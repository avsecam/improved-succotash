extends Event

@onready var marker_2 = $"../../LookAroundChecker/Marker2"

func _on_event_started() -> void:
	clear_event_dialogue()
	marker_2.screen_entered.connect(_on_marker_2_screen_entered)

func _on_marker_2_screen_entered():
	close_event()
