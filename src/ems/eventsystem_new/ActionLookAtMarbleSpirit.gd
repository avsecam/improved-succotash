extends Event

@onready var marble_spirit_on_screen_notifier = $"../../MarbleSpirit_Normal/VisibleOnScreenNotifier3D"
@onready var cooking_vat_long = $"../../cooking_vat_long"

func _on_event_started() -> void:
	clear_event_dialogue()
	marble_spirit_on_screen_notifier.screen_entered.connect(_on_visible_on_screen_notifier_3d_screen_entered)
	await get_tree().create_timer(3.0).timeout
	play_event_audio()



func _on_visible_on_screen_notifier_3d_screen_entered():
	cooking_vat_long.vat_long_receiver.set_monitoring(true)
	close_event()
