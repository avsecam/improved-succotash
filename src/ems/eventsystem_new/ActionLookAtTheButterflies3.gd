extends Event

@onready var marker_3 = $"../../LookAroundChecker/Marker3"

func _on_event_started() -> void:
	clear_event_dialogue()
	marker_3.screen_entered.connect(_on_marker_3_screen_entered)

func _on_marker_3_screen_entered():
	close_event()
