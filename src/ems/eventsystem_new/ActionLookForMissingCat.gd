extends Event

@onready var black_cat_location = $"../../blackcatFriend/black_cat_location"

func _on_event_started() -> void:
	await get_tree().create_timer(3.0).timeout
	black_cat_location.screen_entered.connect(_on_black_cat_location_screen_entered)

func _on_black_cat_location_screen_entered():
	play_event_audio()
	close_event()
