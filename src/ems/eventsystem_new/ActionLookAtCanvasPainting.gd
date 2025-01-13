extends Event

@onready var easel_visible_on_screen_notifier_3d = $"../../Easel_Normal2/VisibleOnScreenNotifier3D"

func _on_event_started() -> void:
	clear_event_dialogue()
	easel_visible_on_screen_notifier_3d.screen_entered.connect(_on_visible_on_screen_notifier_3d_screen_entered)
	await get_tree().create_timer(3.0).timeout
	play_event_audio()

func _on_visible_on_screen_notifier_3d_screen_entered():
	close_event()
