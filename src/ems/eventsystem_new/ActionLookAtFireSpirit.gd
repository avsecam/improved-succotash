extends Event

@onready var fire_spirit_visible_notifier := $"../../FireSpirit_Normal/VisibleOnScreenNotifier3D"

func _on_event_started() -> void:
	fire_spirit_visible_notifier.screen_entered.connect(_on_visible_on_screen_notifier_3d_screen_entered)
	
func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	play_event_audio()
	await event_audio_done
	close_event()
