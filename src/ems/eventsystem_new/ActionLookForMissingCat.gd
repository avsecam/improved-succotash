extends Event

@onready var black_cat_location = $"../../blackcatFriend/black_cat_location"
@onready var cat_voice = $"../../blackcatFriend/cat_voice"

func _on_event_started() -> void:
	AudioHandler.play_sfx("Char_Cat_Meow1", cat_voice)
	await get_tree().create_timer(3.0).timeout
	black_cat_location.screen_entered.connect(_on_black_cat_location_screen_entered)

func _on_black_cat_location_screen_entered():
	play_event_audio()
	AudioHandler.play_sfx("Char_Cat_Meow1", cat_voice)
	close_event()
