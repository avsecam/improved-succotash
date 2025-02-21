extends Event

@onready var easel_visible_on_screen_notifier_3d = $"../../Easel_Normal2/VisibleOnScreenNotifier3D"

func _on_event_started() -> void:
	clear_event_dialogue()
	easel_visible_on_screen_notifier_3d.screen_entered.connect(_on_visible_on_screen_notifier_3d_screen_entered)
	play_event_audio()
	close_event()

func _on_visible_on_screen_notifier_3d_screen_entered():
	clear_event_dialogue()
	await get_tree().create_timer(2.0).timeout
	close_event()
