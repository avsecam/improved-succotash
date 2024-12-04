extends Event

@onready var black_cat_location = $"../../blackcatFriend/black_cat_location"


func _on_event_started() -> void:
	await get_tree().create_timer(5.0).timeout

func _on_black_cat_location_screen_entered():
	close_event()
