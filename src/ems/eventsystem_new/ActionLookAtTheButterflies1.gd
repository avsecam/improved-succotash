extends Event
@onready var marker_1 = $"../../LookAroundChecker/Marker1"

func _on_event_started() -> void:
	clear_event_dialogue()
	marker_1.screen_entered.connect(_on_marker_1_screen_entered)

func _on_marker_1_screen_entered():
	close_event()
